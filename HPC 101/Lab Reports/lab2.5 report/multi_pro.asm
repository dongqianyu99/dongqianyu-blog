a:
        .zero   8
b:
        .zero   8
c:
        .zero   8
d:
        .zero   8
.LC0:
        .string "Initializing"
.LC2:
        .string "Raw computing"
.LC3:
        .string "New computing"
.LC4:
        .string "raw time=%lfs\nnew time=%lfs\nspeed up:%lfx\nChecking\n"
.LC7:
        .string "Check Failed at %d\n"
.LC8:
        .string "Check Passed"
main:
        lea     r10, [rsp+8]
        and     rsp, -32
        push    QWORD PTR [r10-8]
        push    rbp
        mov     rbp, rsp
        push    r10
        sub     rsp, 1256
        mov     edi, OFFSET FLAT:.LC0
        call    puts
        mov     eax, 3840000000
        mov     rdi, rax
        call    malloc
        mov     QWORD PTR a[rip], rax
        mov     eax, 3840000000
        mov     rdi, rax
        call    malloc
        mov     QWORD PTR b[rip], rax
        mov     edi, 1280000000
        call    malloc
        mov     QWORD PTR c[rip], rax
        mov     edi, 1280000000
        call    malloc
        mov     QWORD PTR d[rip], rax
        mov     rax, QWORD PTR c[rip]
        mov     edx, 1280000000
        mov     esi, 0
        mov     rdi, rax
        call    memset
        mov     rax, QWORD PTR d[rip]
        mov     edx, 1280000000
        mov     esi, 0
        mov     rdi, rax
        call    memset
        mov     DWORD PTR [rbp-20], 0
        jmp     .L9
.L10:
        call    rand
        add     eax, 1
        vcvtsi2sd       xmm1, xmm1, eax
        mov     rax, QWORD PTR a[rip]
        mov     edx, DWORD PTR [rbp-20]
        movsx   rdx, edx
        sal     rdx, 3
        add     rax, rdx
        vmovsd  xmm0, QWORD PTR .LC1[rip]
        vdivsd  xmm0, xmm0, xmm1
        vmovsd  QWORD PTR [rax], xmm0
        call    rand
        add     eax, 1
        vcvtsi2sd       xmm1, xmm1, eax
        mov     rax, QWORD PTR b[rip]
        mov     edx, DWORD PTR [rbp-20]
        movsx   rdx, edx
        sal     rdx, 3
        add     rax, rdx
        vmovsd  xmm0, QWORD PTR .LC1[rip]
        vdivsd  xmm0, xmm0, xmm1
        vmovsd  QWORD PTR [rax], xmm0
        add     DWORD PTR [rbp-20], 1
.L9:
        cmp     DWORD PTR [rbp-20], 479999999
        jle     .L10
        mov     edi, OFFSET FLAT:.LC2
        call    puts
        call    std::chrono::_V2::system_clock::now()
        mov     QWORD PTR [rbp-1240], rax
        mov     DWORD PTR [rbp-24], 0
        jmp     .L11
.L18:
        mov     DWORD PTR [rbp-28], 0
        jmp     .L12
.L17:
        mov     DWORD PTR [rbp-32], 0
        jmp     .L13
.L16:
        mov     DWORD PTR [rbp-36], 0
        jmp     .L14
.L15:
        mov     rax, QWORD PTR c[rip]
        mov     edx, DWORD PTR [rbp-24]
        sal     edx, 4
        movsx   rcx, edx
        mov     edx, DWORD PTR [rbp-32]
        sal     edx, 2
        movsx   rdx, edx
        add     rcx, rdx
        mov     edx, DWORD PTR [rbp-28]
        movsx   rdx, edx
        add     rdx, rcx
        sal     rdx, 3
        add     rax, rdx
        vmovsd  xmm1, QWORD PTR [rax]
        mov     rcx, QWORD PTR a[rip]
        mov     edx, DWORD PTR [rbp-24]
        mov     eax, edx
        add     eax, eax
        add     eax, edx
        sal     eax, 4
        movsx   rsi, eax
        mov     edx, DWORD PTR [rbp-32]
        mov     eax, edx
        add     eax, eax
        add     eax, edx
        sal     eax, 2
        cdqe
        lea     rdx, [rsi+rax]
        mov     eax, DWORD PTR [rbp-36]
        cdqe
        add     rax, rdx
        sal     rax, 3
        add     rax, rcx
        vmovsd  xmm2, QWORD PTR [rax]
        mov     rcx, QWORD PTR b[rip]
        mov     edx, DWORD PTR [rbp-24]
        mov     eax, edx
        add     eax, eax
        add     eax, edx
        sal     eax, 4
        movsx   rdx, eax
        mov     eax, DWORD PTR [rbp-36]
        sal     eax, 2
        cdqe
        add     rdx, rax
        mov     eax, DWORD PTR [rbp-28]
        cdqe
        add     rax, rdx
        sal     rax, 3
        add     rax, rcx
        vmovsd  xmm0, QWORD PTR [rax]
        vmulsd  xmm0, xmm2, xmm0
        mov     rax, QWORD PTR c[rip]
        mov     edx, DWORD PTR [rbp-24]
        sal     edx, 4
        movsx   rcx, edx
        mov     edx, DWORD PTR [rbp-32]
        sal     edx, 2
        movsx   rdx, edx
        add     rcx, rdx
        mov     edx, DWORD PTR [rbp-28]
        movsx   rdx, edx
        add     rdx, rcx
        sal     rdx, 3
        add     rax, rdx
        vaddsd  xmm0, xmm1, xmm0
        vmovsd  QWORD PTR [rax], xmm0
        add     DWORD PTR [rbp-36], 1
.L14:
        cmp     DWORD PTR [rbp-36], 11
        jle     .L15
        add     DWORD PTR [rbp-32], 1
.L13:
        cmp     DWORD PTR [rbp-32], 3
        jle     .L16
        add     DWORD PTR [rbp-28], 1
.L12:
        cmp     DWORD PTR [rbp-28], 3
        jle     .L17
        add     DWORD PTR [rbp-24], 1
.L11:
        cmp     DWORD PTR [rbp-24], 9999999
        jle     .L18
        call    std::chrono::_V2::system_clock::now()
        mov     QWORD PTR [rbp-1248], rax
        lea     rdx, [rbp-1240]
        lea     rax, [rbp-1248]
        mov     rsi, rdx
        mov     rdi, rax
        call    std::common_type<std::chrono::duration<long, std::ratio<1l, 1000000000l> >, std::chrono::duration<long, std::ratio<1l, 1000000000l> > >::type std::chrono::operator-<std::chrono::_V2::system_clock, std::chrono::duration<long, std::ratio<1l, 1000000000l> >, std::chrono::duration<long, std::ratio<1l, 1000000000l> > >(std::chrono::time_point<std::chrono::_V2::system_clock, std::chrono::duration<long, std::ratio<1l, 1000000000l> > > const&, std::chrono::time_point<std::chrono::_V2::system_clock, std::chrono::duration<long, std::ratio<1l, 1000000000l> > > const&)
        mov     QWORD PTR [rbp-1224], rax
        lea     rdx, [rbp-1224]
        lea     rax, [rbp-1232]
        mov     rsi, rdx
        mov     rdi, rax
        call    std::chrono::duration<double, std::ratio<1l, 1l> >::duration<long, std::ratio<1l, 1000000000l>, void>(std::chrono::duration<long, std::ratio<1l, 1000000000l> > const&)
        lea     rax, [rbp-1232]
        mov     rdi, rax
        call    std::chrono::duration<double, std::ratio<1l, 1l> >::count() const
        vmovq   rax, xmm0
        mov     QWORD PTR [rbp-224], rax
        mov     edi, OFFSET FLAT:.LC3
        call    puts
        call    std::chrono::_V2::system_clock::now()
        mov     QWORD PTR [rbp-1240], rax
        mov     DWORD PTR [rbp-40], 0
        jmp     .L19
.L35:
        mov     rcx, QWORD PTR a[rip]
        mov     edx, DWORD PTR [rbp-40]
        mov     eax, edx
        add     eax, eax
        add     eax, edx
        sal     eax, 4
        cdqe
        sal     rax, 3
        add     rax, rcx
        mov     QWORD PTR [rbp-240], rax
        mov     rcx, QWORD PTR b[rip]
        mov     edx, DWORD PTR [rbp-40]
        mov     eax, edx
        add     eax, eax
        add     eax, edx
        sal     eax, 4
        cdqe
        sal     rax, 3
        add     rax, rcx
        mov     QWORD PTR [rbp-248], rax
        mov     rax, QWORD PTR d[rip]
        mov     edx, DWORD PTR [rbp-40]
        sal     edx, 4
        movsx   rdx, edx
        sal     rdx, 3
        add     rax, rdx
        mov     QWORD PTR [rbp-256], rax
        mov     rax, QWORD PTR [rbp-240]
        mov     QWORD PTR [rbp-56], rax
        mov     rax, QWORD PTR [rbp-240]
        add     rax, 96
        mov     QWORD PTR [rbp-64], rax
        mov     rax, QWORD PTR [rbp-240]
        add     rax, 192
        mov     QWORD PTR [rbp-72], rax
        mov     rax, QWORD PTR [rbp-240]
        add     rax, 288
        mov     QWORD PTR [rbp-80], rax
        vxorpd  xmm0, xmm0, xmm0
        vmovapd YMMWORD PTR [rbp-112], ymm0
        vxorpd  xmm0, xmm0, xmm0
        vmovapd YMMWORD PTR [rbp-144], ymm0
        vxorpd  xmm0, xmm0, xmm0
        vmovapd YMMWORD PTR [rbp-176], ymm0
        vxorpd  xmm0, xmm0, xmm0
        vmovapd YMMWORD PTR [rbp-208], ymm0
        mov     DWORD PTR [rbp-44], 0
        jmp     .L24
.L34:
        mov     rax, QWORD PTR [rbp-56]
        lea     rdx, [rax+8]
        mov     QWORD PTR [rbp-56], rdx
        vmovsd  xmm0, QWORD PTR [rax]
        vmovsd  QWORD PTR [rbp-264], xmm0
        mov     rax, QWORD PTR [rbp-64]
        lea     rdx, [rax+8]
        mov     QWORD PTR [rbp-64], rdx
        vmovsd  xmm0, QWORD PTR [rax]
        vmovsd  QWORD PTR [rbp-272], xmm0
        mov     rax, QWORD PTR [rbp-72]
        lea     rdx, [rax+8]
        mov     QWORD PTR [rbp-72], rdx
        vmovsd  xmm0, QWORD PTR [rax]
        vmovsd  QWORD PTR [rbp-280], xmm0
        mov     rax, QWORD PTR [rbp-80]
        lea     rdx, [rax+8]
        mov     QWORD PTR [rbp-80], rdx
        vmovsd  xmm0, QWORD PTR [rax]
        vmovsd  QWORD PTR [rbp-288], xmm0
        mov     eax, DWORD PTR [rbp-44]
        sal     eax, 2
        cdqe
        lea     rdx, [0+rax*8]
        mov     rax, QWORD PTR [rbp-248]
        add     rax, rdx
        mov     QWORD PTR [rbp-960], rax
        mov     rax, QWORD PTR [rbp-960]
        vmovupd ymm0, YMMWORD PTR [rax]
        vmovapd YMMWORD PTR [rbp-336], ymm0
        vmovsd  xmm0, QWORD PTR [rbp-264]
        vmovsd  QWORD PTR [rbp-952], xmm0
        vbroadcastsd    ymm0, QWORD PTR [rbp-952]
        vmovapd YMMWORD PTR [rbp-368], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-368]
        vmovapd YMMWORD PTR [rbp-880], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-336]
        vmovapd YMMWORD PTR [rbp-912], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-112]
        vmovapd YMMWORD PTR [rbp-944], ymm0
        vmovapd ymm1, YMMWORD PTR [rbp-912]
        vmovapd ymm0, YMMWORD PTR [rbp-944]
        vfmadd231pd     ymm0, ymm1, YMMWORD PTR [rbp-880]
        nop
        vmovapd YMMWORD PTR [rbp-112], ymm0
        vmovsd  xmm0, QWORD PTR [rbp-272]
        vmovsd  QWORD PTR [rbp-824], xmm0
        vbroadcastsd    ymm0, QWORD PTR [rbp-824]
        vmovapd YMMWORD PTR [rbp-400], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-400]
        vmovapd YMMWORD PTR [rbp-752], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-336]
        vmovapd YMMWORD PTR [rbp-784], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-144]
        vmovapd YMMWORD PTR [rbp-816], ymm0
        vmovapd ymm1, YMMWORD PTR [rbp-784]
        vmovapd ymm0, YMMWORD PTR [rbp-816]
        vfmadd231pd     ymm0, ymm1, YMMWORD PTR [rbp-752]
        nop
        vmovapd YMMWORD PTR [rbp-144], ymm0
        vmovsd  xmm0, QWORD PTR [rbp-280]
        vmovsd  QWORD PTR [rbp-696], xmm0
        vbroadcastsd    ymm0, QWORD PTR [rbp-696]
        vmovapd YMMWORD PTR [rbp-432], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-432]
        vmovapd YMMWORD PTR [rbp-624], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-336]
        vmovapd YMMWORD PTR [rbp-656], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-176]
        vmovapd YMMWORD PTR [rbp-688], ymm0
        vmovapd ymm1, YMMWORD PTR [rbp-656]
        vmovapd ymm0, YMMWORD PTR [rbp-688]
        vfmadd231pd     ymm0, ymm1, YMMWORD PTR [rbp-624]
        nop
        vmovapd YMMWORD PTR [rbp-176], ymm0
        vmovsd  xmm0, QWORD PTR [rbp-288]
        vmovsd  QWORD PTR [rbp-568], xmm0
        vbroadcastsd    ymm0, QWORD PTR [rbp-568]
        vmovapd YMMWORD PTR [rbp-464], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-464]
        vmovapd YMMWORD PTR [rbp-496], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-336]
        vmovapd YMMWORD PTR [rbp-528], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-208]
        vmovapd YMMWORD PTR [rbp-560], ymm0
        vmovapd ymm1, YMMWORD PTR [rbp-528]
        vmovapd ymm0, YMMWORD PTR [rbp-560]
        vfmadd231pd     ymm0, ymm1, YMMWORD PTR [rbp-496]
        nop
        vmovapd YMMWORD PTR [rbp-208], ymm0
        add     DWORD PTR [rbp-44], 1
.L24:
        cmp     DWORD PTR [rbp-44], 11
        jle     .L34
        mov     rax, QWORD PTR [rbp-256]
        mov     QWORD PTR [rbp-1144], rax
        vmovapd ymm0, YMMWORD PTR [rbp-112]
        vmovapd YMMWORD PTR [rbp-1200], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-1200]
        mov     rax, QWORD PTR [rbp-1144]
        vmovupd YMMWORD PTR [rax], ymm0
        nop
        mov     rax, QWORD PTR [rbp-256]
        add     rax, 32
        mov     QWORD PTR [rbp-1080], rax
        vmovapd ymm0, YMMWORD PTR [rbp-144]
        vmovapd YMMWORD PTR [rbp-1136], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-1136]
        mov     rax, QWORD PTR [rbp-1080]
        vmovupd YMMWORD PTR [rax], ymm0
        nop
        mov     rax, QWORD PTR [rbp-256]
        add     rax, 64
        mov     QWORD PTR [rbp-1016], rax
        vmovapd ymm0, YMMWORD PTR [rbp-176]
        vmovapd YMMWORD PTR [rbp-1072], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-1072]
        mov     rax, QWORD PTR [rbp-1016]
        vmovupd YMMWORD PTR [rax], ymm0
        nop
        mov     rax, QWORD PTR [rbp-256]
        add     rax, 96
        mov     QWORD PTR [rbp-968], rax
        vmovapd ymm0, YMMWORD PTR [rbp-208]
        vmovapd YMMWORD PTR [rbp-1008], ymm0
        vmovapd ymm0, YMMWORD PTR [rbp-1008]
        mov     rax, QWORD PTR [rbp-968]
        vmovupd YMMWORD PTR [rax], ymm0
        nop
        add     DWORD PTR [rbp-40], 1
.L19:
        cmp     DWORD PTR [rbp-40], 9999999
        jle     .L35
        call    std::chrono::_V2::system_clock::now()
        mov     QWORD PTR [rbp-1248], rax
        lea     rdx, [rbp-1240]
        lea     rax, [rbp-1248]
        mov     rsi, rdx
        mov     rdi, rax
        call    std::common_type<std::chrono::duration<long, std::ratio<1l, 1000000000l> >, std::chrono::duration<long, std::ratio<1l, 1000000000l> > >::type std::chrono::operator-<std::chrono::_V2::system_clock, std::chrono::duration<long, std::ratio<1l, 1000000000l> >, std::chrono::duration<long, std::ratio<1l, 1000000000l> > >(std::chrono::time_point<std::chrono::_V2::system_clock, std::chrono::duration<long, std::ratio<1l, 1000000000l> > > const&, std::chrono::time_point<std::chrono::_V2::system_clock, std::chrono::duration<long, std::ratio<1l, 1000000000l> > > const&)
        mov     QWORD PTR [rbp-1208], rax
        lea     rdx, [rbp-1208]
        lea     rax, [rbp-1216]
        mov     rsi, rdx
        mov     rdi, rax
        call    std::chrono::duration<double, std::ratio<1l, 1l> >::duration<long, std::ratio<1l, 1000000000l>, void>(std::chrono::duration<long, std::ratio<1l, 1000000000l> > const&)
        lea     rax, [rbp-1216]
        mov     rdi, rax
        call    std::chrono::duration<double, std::ratio<1l, 1l> >::count() const
        vmovq   rax, xmm0
        mov     QWORD PTR [rbp-232], rax
        vmovsd  xmm0, QWORD PTR [rbp-224]
        vdivsd  xmm1, xmm0, QWORD PTR [rbp-232]
        vmovsd  xmm0, QWORD PTR [rbp-232]
        mov     rax, QWORD PTR [rbp-224]
        vmovapd xmm2, xmm1
        vmovapd xmm1, xmm0
        vmovq   xmm0, rax
        mov     edi, OFFSET FLAT:.LC4
        mov     eax, 3
        call    printf
        mov     DWORD PTR [rbp-212], 0
        jmp     .L36
.L40:
        mov     rax, QWORD PTR c[rip]
        mov     edx, DWORD PTR [rbp-212]
        movsx   rdx, edx
        sal     rdx, 3
        add     rax, rdx
        vmovsd  xmm0, QWORD PTR [rax]
        mov     rax, QWORD PTR d[rip]
        mov     edx, DWORD PTR [rbp-212]
        movsx   rdx, edx
        sal     rdx, 3
        add     rax, rdx
        vmovsd  xmm1, QWORD PTR [rax]
        vsubsd  xmm0, xmm0, xmm1
        vmovq   xmm1, QWORD PTR .LC5[rip]
        vandpd  xmm0, xmm0, xmm1
        mov     rax, QWORD PTR d[rip]
        mov     edx, DWORD PTR [rbp-212]
        movsx   rdx, edx
        sal     rdx, 3
        add     rax, rdx
        vmovsd  xmm1, QWORD PTR [rax]
        vdivsd  xmm0, xmm0, xmm1
        vcomisd xmm0, QWORD PTR .LC6[rip]
        jbe     .L42
        mov     eax, DWORD PTR [rbp-212]
        mov     esi, eax
        mov     edi, OFFSET FLAT:.LC7
        mov     eax, 0
        call    printf
        mov     eax, 0
        jmp     .L39
.L42:
        add     DWORD PTR [rbp-212], 1
.L36:
        cmp     DWORD PTR [rbp-212], 159999999
        jle     .L40
        mov     edi, OFFSET FLAT:.LC8
        call    puts
        mov     eax, 0
.L39:
        mov     r10, QWORD PTR [rbp-8]
        leave
        lea     rsp, [r10-8]
        ret
.LC1:
        .long   0
        .long   1072693248
.LC5:
        .long   -1
        .long   2147483647
        .long   0
        .long   0
.LC6:
        .long   -350469331
        .long   1058682594
.LC9:
        .long   0
        .long   1104006501