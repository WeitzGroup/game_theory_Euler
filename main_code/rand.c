//
//  rand.c
//
//
//  Created by Yu-Hui Lin on 5/18/17.
//
//

// uniform random number generator between (0,1]
double rand01()
{
    return (double)rand() / (double)RAND_MAX ;
}

// random permutation of series [1:N]
double* randperm(long N){
    
    int i, j, temp, ind;
    double* N_vec,* wheel, * perm_vec;
    double r;
    N_vec = d_vec(N);
    wheel = d_vec(N+1);
    perm_vec = d_vec(N);
    
    /** create a series [1:N] */
    for(i = 0; i < N; i++){
        N_vec[i] = i+1;
    }
    
    for(i = 0; i < N; i++){        
        /** random choose a number from unchosen pool **/
        r = rand01();
        for (j = 0; j < N-i; j++){
            wheel[j] = (double)j/(double)(N-i);
            wheel[j+1] = (double)(j+1)/(double)(N-i);
            if((r > wheel[j]) && (r<=wheel[j+1])){
                ind = j;
                break;
            }
        }
        
        /** swipe the latest number with chosen one **/
        temp = N_vec[N-i-1];
        N_vec[N-i-1] = N_vec[ind];
        N_vec[ind] = temp;
    }
    
    
    free_d_vec(wheel);
    return N_vec;
}
