# HPC Notebook

在做 PAC 比赛时第一次接触了 HPC ，由于只上了一个短学期，相关知识极度匮乏，优化根本无从下手。为此，我认为有必要系统性的补全相关的知识，做一些相关的积累，这对日后的计科学习想必也是大有裨益的。  

这个 notebook 一方面记录 HPC 的相关知识，另一方面也是一个学习路径的记录。最为一个完全的小白，从zhb处得到建议，决定以[Bowling's TechStack](https://note.bowling233.top/%E9%AB%98%E6%80%A7%E8%83%BD%E8%AE%A1%E7%AE%97/)为指导框架，往里面填充知识；同时该文档也是一个起点，向外发散拓展。

---

直接盗用 Bowling 的结构图和优化框架：  

![alt text](image.png)  
 
优化主要在两个层面进行：**代码层面**和**运行层面**。

代码优化
- 三大并行编程模型
    - MPI
    - OpenMP
    - CUDA
- 常见实现、编译器和工具链对应的优化策略
    - GCC（OpenMPI）
    - Intel（Intel MPI）
    - NVIDIA（NVCC）

代码优化的目标是编写具有**可扩展性**的代码。可扩展性是指，随着计算资源的增加，代码的性能也能够线性（甚至更好地增长）。在不考虑实现的阶段，我们需要按照对应编程模型的最佳实践编写代码。在考虑实现的阶段，我们需要根据实现的特点和硬件架构的特点，针对性地优化代码，比如采用特定的指令集等。

运行优化
- CPU 计算（MPI）
    - 绑核
    - 节点、进程、线程拓扑
- GPU 计算
    - SM、Warp 调度

运行优化一定程度上是不断的尝试，探索在如何最大化利用硬件资源。  

由于开始这个文档的时间正好是Lab3即将开始的时候，所以我们先从 **CUDA** 开始

## CUDA  

### GPU & SPMD

Where are we?

![alt text](image-1.png)  

Why **GPU**? Need More Computing Power.  

![alt text](image-2.png)  

特别有趣的图片解释了 CPU 与 GPU 之间的关系  

![alt text](image-3.png)  

GPU 只是一个计算工具，依旧需要在 CPU 的指令下工作  

More cores -> More trouble  
How to manipulate them?  

![alt text](image-4.png)  

CPU-GPU Co-processing: 
- CPU: Sequential or modestly parallel sections
- **GPU: Massively parallel sections**

The instruction pipeline operates **like a SIMD pipeline** (e.g., an array processor). However, the programming is done **using threads**, NOT SIMD instructions

First, let’s distinguish between 
- **Programming Model (Software)**
          vs.
- **Execution Model (Hardware)**  

Programming Model： how the programmer expresses the code
E.g., Sequential (von Neumann), Data Parallel (SIMD), Dataflow, Multi-threaded (MIMD, SPMD), …

Hardware Execution Model： how the hardware executes the code underneath
E.g., Out-of-order execution, Vector processor, Array processor, Dataflow processor, Multiprocessor, Multithreaded processor, …

**Execution Model can be very different from Programming Model**
E.g., von Neumann model implemented by an OoO processor
E.g., SPMD model implemented by a SIMD processor (a GPU)

![alt text](image-5.png)  

**NVIDIA A100 & NVIDIA H100** 

![alt text](image-6.png)  

![alt text](image-7.png)  

![alt text](image-8.png)  

![alt text](image-9.png)  

GPU Trend H100 vs. A100  
**Compute power scales well.**
**GPU memory capacity does not scale well.**

![alt text](image-10.png)  

A GPU is a SIMD (SIMT) Machine，Except it is *NOT* programmed using SIMD instructions

It is **programmed using threads (SPMD programming model)**
- Each thread **executes the same code but operates a different piece of data**
- Each thread **has its own context** (i.e., can be treated/restarted/executed independently)  

**SISD vs. SIMD vs. SPMD**

How Can You Exploit Parallelism Here?  

~~~c  
for (int i=0; i<N; i++)
{
    C[i] = A[i] + B[i];
}
~~~  

Let’s examine three programming options to exploit **instruction-level parallelism** present in this sequential code:
- Sequential (SISD)
- Data-Parallel (SIMD)
- Multithreaded (SPMD)

Prog. Model 1: Sequential (SISD)  

![alt text](image-11.png)  

Can be executed on thee processors:
- Pipelined processor
- Out-of-order execution processor
    - Independent instructions executed when ready
    - Different iterations are present in the instruction window and can execute in parallel in multiple functional units
    - In other words, **the loop is dynamically unrolled by the hardware**
- Superscalar or VLIW processor
Can fetch and execute multiple instructions per cycle

Prog. Model 2: Data Parallel (SIMD)  

![alt text](image-12.png)  

- Realization: Each iteration is independent
- Idea: Programmer or compiler generates a SIMD instruction to execute the same instruction from all iterations across different data

Prog. Model 3: Multithreaded  

![alt text](image-13.png)  

- Realization: Each iteration is independent
- Idea: Programmer or compiler generates a thread to execute each iteration. Each thread does the same thing (but on different data)  

This programming model (software) is called:  
**SPMD: Single Program Multiple Data**
- This is a **programming model** rather than computer organization  
- Each processing element executes the **same procedure**, except on **different data elements**
    - Procedures can synchronize at certain points in program, e.g. barriers

**Key Idea of SPMD: multiple instruction streams execute the same program**
- Each program/procedure  
    - works on different data,  
    - can execute a different control-flow path, at run-time
- Many scientific applications are programmed this way and run on MIMD hardware (multiprocessors)
- Modern GPUs programmed in a similar way on a SIMD hardware

接下来的部分将参照 NVIDIA 深度学习培训中心（DLI）实战培训课程[计算加速基础——C](https://learn.nvidia.com/courses/course?course_id=course-v1:DLI+C-AC-01+V1-ZH&unit=block-v1:DLI+C-AC-01+V1-ZH+type@vertical+block@b8bf5b6c2f3b4697a2f0751fc4749643)  
在官方教程中使用了 jupyter 交互式笔记本和云端的 NVIDIA GPU 的加速系统。我的电脑上居然也有一块 NVIDIA GEFORCE RTX，所以我想尝试在我的电脑复现。

![alt text](CUDA_Logo.jpg)

### 使用 CUDA C/C++ 加速应用程序  
CUDA 提供一种可扩展 C、C++、Python 和 Fortran 等语言的编码范式，能够在世界上性能超强劲的并行处理器 NVIDIA GPU 上运行大量经加速的并行代码。CUDA 可以毫不费力地大幅加速应用程序，具有适用于 [DNN](https://developer.nvidia.com/cudnn)、[BLAS](https://developer.nvidia.com/cublas)、[图形分析](https://developer.nvidia.com/nvgraph) 和 [FFT](https://developer.nvidia.com/cufft) 等的高度优化库生态系统，并且还附带功能强大的 [命令行](http://docs.nvidia.com/cuda/profiler-users-guide/index.html#nvprof-overview) 和 [可视化分析器](http://docs.nvidia.com/cuda/profiler-users-guide/index.html#visual)。  

#### 加速系统  
加速系统又称**异构系统**，由 CPU 和 GPU 组成。加速系统会运行 CPU 程序，这些程序也会转而启动将受益于 GPU 大规模并行计算能力的函数。  

可以使用 `nvidia-smi` (Systems Management Interface) 命令行命令查询有关此 GPU 的信息。  

![alt text](image-14.png)  

#### 由GPU加速的还是纯CPU的应用程序  

在 CPU 应用程序中，数据在 CPU 上进行分配，并且所有工作均在 CPU 上进行。  

![alt text](image-15.png)  

而在加速应用程序中，则可以使用 `cudaMallocManaged()` 分配数据，其数据可**由 CPU 进行访问和处理**，并能自动迁移至可执行并行工作的 GPU；**GPU 异步执行工作**，与此同时 CPU 可执行它的工作；通过 `cudaDeviceSynchronized`，CPU 代码可与异步 GPU 工作实现**同步**，并等待后者完成；经 CPU 访问的数据将会自动迁移。  

![alt text](image-16.png)  

#### 为GPU编写应用程序代码  

CUDA 为许多常用编程语言提供扩展。这些语言扩展可让开发人员在 GPU 上轻松运行其源代码中的函数。

要复现文档中的 CUDA 程序，需要安装[CUDA Toolkit](https://developer.nvidia.com/cuda-toolkit-archive)。  

显然 CUDA 是可以配置在 VS Code 上的，但鬼知道我找了多少教程配置了多久，总之最后成功在 Visual Studio 2022 上配置成功。具体参考[Youtube Vidio](https://www.youtube.com/watch?v=3usDbpnn7E8)。