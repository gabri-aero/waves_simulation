# Numerical 2D wave simulation
- A variety of numerical simulations of 2D wave equation using Finite Difference Method. 
- Simulation-based analysis of wave basic phenomena: diffraction and interference.

## The Wave Equation
<div align="center">
<img src="https://latex.codecogs.com/svg.image?u=u(x,y,t)" title="u=u(x,y,t)" /> <br>
<img src="https://latex.codecogs.com/svg.image?u_{tt}=\nabla&space;u&space;\xrightarrow{}&space;u_{tt}=u_{xx}&plus;u_{yy}" title="u_{tt}=\nabla u \xrightarrow{} u_{tt}=u_{xx}+u_{yy}" /><br>
  <img src="https://latex.codecogs.com/svg.image?\frac{\partial^2&space;u(x,y,t)}{\partial&space;t^2}=\frac{\partial^2&space;u(x,y,t)}{\partial&space;x^2}&plus;\frac{\partial^2&space;u(x,y,t)}{\partial&space;y^2}" title="\frac{\partial^2 u(x,y,t)}{\partial t^2}=\frac{\partial^2 u(x,y,t)}{\partial x^2}+\frac{\partial^2 u(x,y,t)}{\partial y^2}" />
</div>

### Initial conditions
<div align="center">
  <img src="https://latex.codecogs.com/svg.image?u(x,y,0)=f(x,y)" title="u(x,y,0)=f(x,y)" /><br>
  <img src="https://latex.codecogs.com/svg.image?u_{t}(x,y,0)=g(x,y)" title="u_{t}(x,y,0)=g(x,y)" />
</div>
To run all the simulations I have used the same IC
<div align="center">
  <img src="https://latex.codecogs.com/svg.image?u(x,y,0)=e^{-1000(x^2&plus;y^2)}" title="u(x,y,0)=e^{-1000(x^2+y^2)}" /><br>
  <img src="https://latex.codecogs.com/svg.image?u_{t}(x,y,0)=0" title="u_{t}(x,y,0)=0" />
</div>
This IC best simulates a puntual wave source caused by a droplet in a water surface for instance.

### Boundary conditions
I have define a squared domain with boundaries sufficiently far away from the region of study that they will not have a particular influence. However I have run some tests with homogeneus Dirichlet conditions, which are the simplest ones.
- Dirichlet conditions:
<div align="center">
  <img src="https://latex.codecogs.com/svg.image?u(x,0,t)=A(x,t)" title="u(x,0,t)=A(x,t)" /><br>
  <img src="https://latex.codecogs.com/svg.image?u(x,L,t)=B(x,t)" title="u(x,L,t)=B(x,t)" /><br>
  <img src="https://latex.codecogs.com/svg.image?u(0,y,t)=C(y,t)" title="u(0,y,t)=C(y,t)" /><br>
  <img src="https://latex.codecogs.com/svg.image?u(L,y,t)=D(y,t)" title="u(L,y,t)=D(y,t)" />
</div>

## The Finite Difference Method
Based on numerical differentiation expressions, we can handle easily PDEs. Given that the basic wave equation consists of 2nd order partial derivatives, the same expresion can be used to simpify the whole equation:
<div align="center">
  <img src="https://latex.codecogs.com/svg.image?f''(x_0)\approx\frac{x_{-1}-2x_0&plus;x_1}{h^2}" title="f''(x_0)\approx\frac{x_{-1}-2x_0+x_1}{h^2}" />
</div>

### Space-time discretization
In this problem, there are 3 variables involved: 2 space dimensions and time. So, we will perform a 3D discretization which consists of splitting every dimension in parts to perform numerical solution of the wave equation. 
<div align="center">
  <img src="https://latex.codecogs.com/svg.image?x=x_0&plus;i\Delta&space;x" title="x=x_0+i\Delta x" /><br>
  <img src="https://latex.codecogs.com/svg.image?y=y_0&plus;j\Delta&space;y" title="y=y_0+j\Delta y" /><br>
  <img src="https://latex.codecogs.com/svg.image?t=k\Delta&space;t" title="t=k\Delta t" />
</div>
For simplicity, mesh will be equal in both spatial dimensions:
<div align="center">
  <img src="https://latex.codecogs.com/svg.image?\Delta&space;x=\Delta&space;y=h" title="\Delta x=\Delta y=h" />
</div>

### Wave PDE algorithm 
<div align="center">
  <img src="https://latex.codecogs.com/svg.image?u(x_i,y_j,t_k)=u_{i,j,k}" title="u(x_i,y_j,t_k)=u_{i,j,k}" /><br>
  <img src="https://latex.codecogs.com/svg.image?\frac{u_{i,j,k-1}-2u_{i,j,k}&plus;u_{i,j,k&plus;1}}{k^2}=\frac{u_{i-1,j,k}-2u_{i,j,k}&plus;u_{i&plus;1,j,k}}{h^2}&plus;\frac{u_{i,j-1,k}-2u_{i,j,k}&plus;u_{i,j&plus;1,k}}{h^2}" title="\frac{u_{i,j,k-1}-2u_{i,j,k}+u_{i,j,k+1}}{k^2}=\frac{u_{i-1,j,k}-2u_{i,j,k}+u_{i+1,j,k}}{h^2}+\frac{u_{i,j-1,k}-2u_{i,j,k}+u_{i,j+1,k}}{h^2}" /><br>
  <img src="https://latex.codecogs.com/svg.image?\frac{u_{i,j,k-1}-2u_{i,j,k}&plus;u_{i,j,k&plus;1}}{k^2}=\frac{u_{i-1,j,k}&plus;u_{i&plus;1,j,k}&plus;u_{i,j-1,k}&plus;u_{i,j&plus;1,k}-4u_{i,j,k}}{h^2}" title="\frac{u_{i,j,k-1}-2u_{i,j,k}+u_{i,j,k+1}}{k^2}=\frac{u_{i-1,j,k}+u_{i+1,j,k}+u_{i,j-1,k}+u_{i,j+1,k}-4u_{i,j,k}}{h^2}" /><br>
  <b>GENERAL ALGORITHM</b><br>
<img style="border: 1px solid; color: black;" src="https://latex.codecogs.com/svg.image?u_{i,j,k&plus;1}=-u_{i,j,k-1}&plus;2u_{i,j,k}&plus;k^2\frac{u_{i-1,j,k}&plus;u_{i&plus;1,j,k}&plus;u_{i,j-1,k}&plus;u_{i,j&plus;1,k}-4u_{i,j,k}}{h^2}" title="u_{i,j,k+1}=-u_{i,j,k-1}+2u_{i,j,k}+k^2\frac{u_{i-1,j,k}+u_{i+1,j,k}+u_{i,j-1,k}+u_{i,j+1,k}-4u_{i,j,k}}{h^2}" />
</div>

## Double slit experiment

https://user-images.githubusercontent.com/79655304/151731411-84bb005f-219c-4fd4-b360-a3cd267c929c.mp4



