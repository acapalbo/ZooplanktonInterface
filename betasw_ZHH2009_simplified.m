function [betaTotal,betasw,beta90sw,bsw]= betasw_ZHH2009_simplified(b_w,b_p,Bpin,lambda,Tc,theta,S,delta)
Bp=Bpin;
fff1='-Bp+1-(1-(0.6777*(0.01-0.3084*nu)^-2)^(nu+1)-0.5*(1-(0.6777*(0.01-0.3084*nu)^-2)^nu))';
fff2='/((1-(0.6777*(0.01-0.3084*nu)^-2))*(0.6777*(0.01-0.3084*nu)^-2)^nu)';
fbpnui=inline([fff1 fff2],'nu','Bp');% Break it into two lines.
[nusol,fval]=fzero(fbpnui,0,[],Bp);% The fval is in there only to distinguish fzero from the old fzero;
mu=3-2*nusol;
np=1.01+0.1542*(mu-3); % This is the relation between mu and np given in Mobley et al.


nu=(3-mu)/2;
delta180=(4/(3*(np-1)^2));% delta evaluated at 180 degrees.
for ii=1:18001 %change to 18001 from 1801, for higher resolution AT 
    theta(ii)=(ii-1)/100;%scattering angle in degrees. Change 10 to 100, for higher resolution AT
    thetar=((ii-1)/100)*pi/180; %convert to radians.  Change 10 to 100, for higher resolution AT
    delta=(4/(3*(np-1)^2))*sin(thetar/2)^2;
    omd=1-delta;
    betaFF(ii)=(1/(4*pi*omd^2*delta^nu))*(nu*omd-(1-delta^nu)+...
        (delta*(1-delta^nu)-nu*omd)*sin(thetar/2)^-2)+...
        ((1-delta180^nu)/(16*pi*(delta180-1)*delta180^nu))*(3*cos(thetar)^2-1);
end


n_air = 1.0+(5792105.0./(238.0185-1./(lambda/1e3).^2)+167917.0./(57.362-1./(lambda/1e3).^2))/1e8;

Na = 6.0221417930e23 ;   %  Avogadro's constant
Kbz = 1.3806503e-23 ;    %  Boltzmann constant
Tk = Tc+273.15 ;         %  Absolute tempearture
M0 = 18e-3;              %  Molecular weigth of water in kg/mol

lambda = lambda(:)'; % a row variable
rad = theta(:)*pi/180; % angle in radian as a colum variable


% refractive index of seawater is from Quan and Fry (1994, Applied Optics)
n0 = 1.31405; n1 = 1.779e-4 ; n2 = -1.05e-6 ; n3 = 1.6e-8 ; n4 = -2.02e-6 ;
n5 = 15.868; n6 = 0.01155;  n7 = -0.00423;  n8 = -4382 ; n9 = 1.1455e6;


nsw = n0+(n1+n2*Tc+n3*Tc^2)*S+n4*Tc^2+(n5+n6*S+n7*Tc)./lambda+n8./lambda.^2+n9./lambda.^3; % pure seawater
nsw = nsw.*n_air;
dnds = (n1+n2*Tc+n3*Tc^2+n6./lambda).*n_air;

kw = 19652.21+148.4206*Tc-2.327105*Tc.^2+1.360477e-2*Tc.^3-5.155288e-5*Tc.^4;
Btw_cal = 1./kw;


% isothermal compressibility from Kell sound measurement in pure water
% Btw = (50.88630+0.717582*Tc+0.7819867e-3*Tc.^2+31.62214e-6*Tc.^3-0.1323594e-6*Tc.^4+0.634575e-9*Tc.^5)./(1+21.65928e-3*Tc)*1e-6;


% seawater secant bulk
a0 = 54.6746-0.603459*Tc+1.09987e-2*Tc.^2-6.167e-5*Tc.^3;
b0 = 7.944e-2+1.6483e-2*Tc-5.3009e-4*Tc.^2;


Ks =kw + a0*S + b0*S.^1.5;


% calculate seawater isothermal compressibility from the secant bulk
IsoComp = 1./Ks*1e-5; % unit is pa

% density of water and seawater,unit is Kg/m^3, from UNESCO,38,1981
a0 = 8.24493e-1;  a1 = -4.0899e-3; a2 = 7.6438e-5; a3 = -8.2467e-7; a4 = 5.3875e-9;
a5 = -5.72466e-3; a6 = 1.0227e-4;  a7 = -1.6546e-6; a8 = 4.8314e-4;
b0 = 999.842594; b1 = 6.793952e-2; b2 = -9.09529e-3; b3 = 1.001685e-4;
b4 = -1.120083e-6; b5 = 6.536332e-9;
 
% density for pure water 
density_w = b0+b1*Tc+b2*Tc^2+b3*Tc^3+b4*Tc^4+b5*Tc^5;
% density for pure seawater
density_sw = density_w +((a0+a1*Tc+a2*Tc^2+a3*Tc^3+a4*Tc^4)*S+(a5+a6*Tc+a7*Tc^2)*S.^1.5+a8*S.^2);

dlnawds = (-5.58651e-4+2.40452e-7*Tc-3.12165e-9*Tc.^2+2.40808e-11*Tc.^3)+......
           1.5*(1.79613e-5-9.9422e-8*Tc+2.08919e-9*Tc.^2-1.39872e-11*Tc.^3).*S.^0.5+......
           2*(-2.31065e-6-1.37674e-9*Tc-1.93316e-11*Tc.^2).*S;

n_wat2 = nsw.^2;
n_density_derivative=(n_wat2-1).*(1+2/3*(n_wat2+2).*(nsw/3-1/3./nsw).^2);

% volume scattering at 90 degree due to the density fluctuation
beta_df = pi*pi/2*((lambda*1e-9).^(-4))*Kbz*Tk*IsoComp.*n_density_derivative.^2*(6+6*delta)/(6-7*delta);
% volume scattering at 90 degree due to the concentration fluctuation
flu_con = S*M0*dnds.^2/density_sw/(-dlnawds)/Na;
beta_cf = 2*pi*pi*((lambda*1e-9).^(-4)).*nsw.^2.*(flu_con)*(6+6*delta)/(6-7*delta);
% total volume scattering at 90 degree
beta90sw = beta_df+beta_cf;
bsw=8*pi/3*beta90sw*(2+delta)/(1+delta);
for i=1:length(lambda)
    betasw(:,i)=beta90sw(i)*(1+((cos(rad)).^2).*(1-delta)/(1+delta));
end

betaTotal = (b_w/(b_w+b_p))*betasw + (b_p/(b_w+b_p))*betaFF';

end