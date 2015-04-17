/**
 * Copyright (C) 2012 Quan Wang <wangq10@rpi.edu>,
 * Signal Analysis and Machine Perception Laboratory,
 * Department of Electrical, Computer, and Systems Engineering,
 * Rensselaer Polytechnic Institute, Troy, NY 12180, USA
 *
 * Quan Wang, Kim L. Boyer, 
 * The active geometric shape model: A new robust deformable shape model and its applications, 
 * Computer Vision and Image Understanding, Volume 116, Issue 12, December 2012, Pages 1178-1194, 
 * ISSN 1077-3142, 10.1016/j.cviu.2012.08.004. 
 *
 * Usage:
 *     H=CircleHoughTransform(I,rmin,rmax,P)
 *         I: 2D binary image 
 *         rmin: smallest radius to be considered
 *         rmax: largest radius to be considered
 *         P: precision
 *             e.g. P=5 means step size is 1/5=0.2
 */

#include "mex.h"
#include <cstdlib>
#include <cstdio>
#include <cmath>
#include <iostream>

using namespace std;

double myround(double a)
{
    if(a-floor(a)>0.5) return floor(a)+1;
    else return floor(a);
}

long H_index(long y, long x, long r, int *dim)
{
    long i=(y-1)+(x-1)*(long)dim[0]+(r-1)*(long)dim[0]*(long)dim[1];
    if(i>=(long)dim[0]*(long)dim[1]*(long)dim[2])
    {
        cout<<"Error: Index out of bound!"<<endl;
        return 0;
    }
    return i;
}

void hough(double *I, int m, int n, double rmin, double rmax, int* dim, double P, double *H)
{
    cout<<"Running Hough transform ..."<<endl;
    long i,j;
    double x_index, y_index, r_index, xx, yy, r;
    
    for(i=1;i<=m;i++)
    {
        for(j=1;j<=n;j++)
        {
            if(I[(i-1)+(j-1)*m]<0.5) continue;
            for(x_index=1;x_index<=dim[1];x_index++)
            {
                xx=(x_index-1)/P+1;
                for(y_index=1;y_index<=dim[0];y_index++)
                {
                    yy=(y_index-1)/P+1;
                    r=sqrt((xx-j)*(xx-j)+(yy-i)*(yy-i));
                    r=myround(r*P)/P;
                    if(r<rmin || r>rmax) continue;
                    r_index=(r-rmin)*P+1;
                    H[ H_index((long)y_index,(long)x_index,(long)r_index,dim) ]=H[ H_index((long)y_index,(long)x_index,(long)r_index,dim) ]+1;
                }
            }
        }
    }
}

void mexFunction( int nlhs, mxArray *plhs[],
        int nrhs, const mxArray *prhs[])
{
    // check input
    if(nrhs!=4)
    {
        mexErrMsgIdAndTxt( "MATLAB:CircleHoughTransform:invalidNumInputs",
                "Four inputs required.");
    }
    if(nlhs!=1)
    {
        mexErrMsgIdAndTxt( "MATLAB:CircleHoughTransform:invalidNumOutputs",
                "One output required.");
    }
    
    // get I
    double *I=mxGetPr(prhs[0]);
    int m=(int)mxGetM(prhs[0]);
    int n=(int)mxGetN(prhs[0]);
    
    if(m<5 || n<5)
    {
        mexErrMsgIdAndTxt( "MATLAB:CircleHoughTransform:matrixTooSmall",
                "Input matrix is too small.");
    }
    
    // get rmin and rmax
    if( !mxIsDouble(prhs[1]) || mxIsComplex(prhs[1]) ||
            mxGetN(prhs[1])*mxGetM(prhs[1])!=1 )
    {
        mexErrMsgIdAndTxt( "MATLAB:CircleHoughTransform:rminNotScalar",
                "Input rmin must be a scalar.");
    }
    double rmin=mxGetScalar(prhs[1]);
    
    if( !mxIsDouble(prhs[2]) || mxIsComplex(prhs[2]) ||
            mxGetN(prhs[2])*mxGetM(prhs[2])!=1 )
    {
        mexErrMsgIdAndTxt( "MATLAB:CircleHoughTransform:rmaxNotScalar",
                "Input rmax must be a scalar.");
    }
    double rmax=mxGetScalar(prhs[2]);
    
    // get P
    if( !mxIsDouble(prhs[3]) || mxIsComplex(prhs[3]) ||
            mxGetN(prhs[3])*mxGetM(prhs[3])!=1 )
    {
        mexErrMsgIdAndTxt( "MATLAB:CircleHoughTransform:PNotScalar",
                "Input P must be a scalar.");
    }
    double P=mxGetScalar(prhs[3]);
    
    // set output
    int *dim=new int[3];
    dim[0]=(m-1)*P+1;
    dim[1]=(n-1)*P+1;
    dim[2]=((int)rmax-(int)rmin)*P+1;
    cout<<"Size of volume: "<<dim[0]<<"*"<<dim[1]<<"*"<<dim[2]<<endl;
    plhs[0] = mxCreateNumericArray(3, dim, mxDOUBLE_CLASS, mxREAL);
    
    double *H=mxGetPr(plhs[0]);
    
    // run C++ function
    hough(I,m,n,rmin,rmax,dim,P,H);
    
    delete[] dim;
}