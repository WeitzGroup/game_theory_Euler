#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <math.h>

/* define some global constants */
#define pi      3.14159265
#define spatial 1       // 1 for spatial simulation, 0 otherwise
#define conti   0       // 1 to load previous simulation results, 0 otherwise
#define b_step  100     // b for buffer, print out results every b_step

/* defining coordinate with interger indices */
struct coordinate{
    long r;     // index of row
    long c;     // index of column
};


/* define variables */
double x0, n0, D, epsi, theta;
double R0, S0, T0, P0;
double R1, S1, T1, P1;
double dt, dx;
int L, Tf;
unsigned int rseed;

double **x, **n;
double **dyn;

/* include scripts of customized functions */
#include "alloc.c"
#include "innout.c"
#include "initialization.c"
#include "rand.c"
#include "fxs_pbc.c"
