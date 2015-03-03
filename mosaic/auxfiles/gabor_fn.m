function gb=gabor_fn(sigma_x,sigma_y,theta,freq,sc)
% Sigma_x and Sigma_y must be integers

if nargin == 4
    sc = 6;
end

sz_x=sc;
sz_y=sc;

[x y]=meshgrid(-fix(sz_x/2):fix(sz_x/2),fix(-sz_y/2):fix(sz_y/2));

% Rotation 
x_theta=x*cos(theta)+y*sin(theta);
y_theta=-x*sin(theta)+y*cos(theta);

gb=exp(-.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2)).*cos(2*pi*freq*x_theta);