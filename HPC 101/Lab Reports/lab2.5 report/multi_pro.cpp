#include <stdio.h>
#include <chrono>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <smmintrin.h>
#include <emmintrin.h>
#include <immintrin.h>

#define MAXN 10000000

double *a;
double *b;
double *c;
double *d;

int main()
{
    printf("Initializing\n");
    a = (double *)malloc(sizeof(double) * MAXN * 48); // 4*12
    b = (double *)malloc(sizeof(double) * MAXN * 48); // 12*4
    c = (double *)malloc(sizeof(double) * MAXN * 16); // 4*4
    d = (double *)malloc(sizeof(double) * MAXN * 16); // 4*4
    memset(c, 0, sizeof(double) * MAXN * 16);
    memset(d, 0, sizeof(double) * MAXN * 16);
    for (int i = 0; i < MAXN * 48; i++)  //initialize
    {
        *(a + i) = 1.0 / (rand() + 1);
        *(b + i) = 1.0 / (rand() + 1);
    }

    printf("Raw computing\n");
    auto start = std::chrono::high_resolution_clock::now();  //timing
    for (int n = 0; n < MAXN; n++)  //MAXN times
    {
        for (int k = 0; k < 4; k++)
        {
            for (int i = 0; i < 4; i++)
            {
                for (int j = 0; j < 12; j++)
                {
                    *(c + n * 16 + i * 4 + k) += *(a + n * 48 + i * 12 + j) * *(b + n * 48 + j * 4 + k);
                }
            }
        }
    }
    auto end = std::chrono::high_resolution_clock::now();

    double time1 = std::chrono::duration<double>(end - start).count();

    printf("New computing\n");
    start = std::chrono::high_resolution_clock::now();
    for (int n = 0; n < MAXN; n++)
    {
        //printf("1\n");
        /* 可以修改的代码区域 */
        // -----------------------------------
        // for (int k = 0; k < 4; k++)
        // {
        //     for (int i = 0; i < 4; i++)
        //     {
        //         for (int j = 0; j < 12; j++)
        //         {
        //             *(d + n * 16 + i * 4 + k) += *(a + n * 48 + i * 12 + j) * *(b + n * 48 + j * 4 + k);
        //         }
        //     }
        // }
        double *a_ptr = a + n * 48, *b_ptr = b + n * 48;
        double *d_ptr = d + n * 16;
        int k;
        double *a_ptr_0,*a_ptr_1,*a_ptr_2,*a_ptr_3;
        a_ptr_0=&a_ptr[0*12+0];
        a_ptr_1=&a_ptr[1*12+0];
        a_ptr_2=&a_ptr[2*12+0];
        a_ptr_3=&a_ptr[3*12+0];

        __m256d c_sum_0 = _mm256_setzero_pd();  
        __m256d c_sum_1 = _mm256_setzero_pd();  
        __m256d c_sum_2 = _mm256_setzero_pd();  
        __m256d c_sum_3 = _mm256_setzero_pd(); 

        double a_reg_0,a_reg_1,a_reg_2,a_reg_3;

        for (k = 0; k < 12;k++){
            a_reg_0 = *(a_ptr_0++);
            a_reg_1 = *(a_ptr_1++);
            a_reg_2 = *(a_ptr_2++);
            a_reg_3 = *(a_ptr_3++);

            __m256d b_reg = _mm256_loadu_pd(&b_ptr[k * 4 + 0]);

            __m256d a_vec_0 = _mm256_set1_pd(a_reg_0);
            c_sum_0 = _mm256_fmadd_pd(a_vec_0, b_reg,c_sum_0);
            __m256d a_vec_1 = _mm256_set1_pd(a_reg_1);
            c_sum_1 = _mm256_fmadd_pd(a_vec_1, b_reg,c_sum_1);
            __m256d a_vec_2 = _mm256_set1_pd(a_reg_2);
            c_sum_2 = _mm256_fmadd_pd(a_vec_2, b_reg,c_sum_2);
            __m256d a_vec_3 = _mm256_set1_pd(a_reg_3);
            c_sum_3 = _mm256_fmadd_pd(a_vec_3, b_reg,c_sum_3);

        }

        _mm256_storeu_pd(d_ptr, c_sum_0);
        _mm256_storeu_pd(d_ptr+4, c_sum_1);
        _mm256_storeu_pd(d_ptr+8, c_sum_2);
        _mm256_storeu_pd(d_ptr+12, c_sum_3);

        // -----------------------------------

    }
    end = std::chrono::high_resolution_clock::now();

    double time2 = std::chrono::duration<double>(end - start).count();
    printf("raw time=%lfs\nnew time=%lfs\nspeed up:%lfx\nChecking\n", time1, time2, time1 / time2);

    for (int i = 0; i < MAXN * 16; i++)
    {
        if (fabs(c[i] - d[i]) / d[i] > 0.0001)
        {
            printf("Check Failed at %d\n", i);
            return 0;
        }
    }
    printf("Check Passed\n");
}

