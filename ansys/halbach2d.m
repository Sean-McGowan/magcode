clear all;close all;clc;
!del C:\magcode\ansys\halbach2d.txt
mu = 1.05;
mu0 = 4*pi*10^-7;
h1 = 1.2/(mu*mu0);                  % Coercivity inner magnet
h2 = 1.2/(mu*mu0);                  % Coercivity outer magnet
pi = 4*atan(1);
N = 8;                              % Number of magnets
theta = pi/(N/2);                   % Angle of 'cube' rotation
angle = theta/(2*pi)*360;           % Angle of 'cube' rotation in degrees
mesh = .01;                        % Mesh size
quote = '''';

a = .6;                             % Airgap width
b = .6;                             % Airgap heigth
c = .08;                            % Outer ring inner radius
d = .1;                             % Outer ring outer radius
e = .03;                            % Inner ring inner radius
f = .05;                            % Inner ring outer radius
g = .035;                            % Outer 'cube' side length
k = .015;                            % Inner 'cube' side length

fid1 = fopen('halbach2d.txt','wt');
fprintf(fid1,'/PREP7\n');
fprintf(fid1,'/TITLE, HALBACH CUBES\n');
fprintf(fid1,'KEYW,PR_SET,1\n');    % Needed?
fprintf(fid1,'KEYW,PR_ELMAG,1\n');  % Needed?
fprintf(fid1,'KEYW,MAGNOD,1\n');    % Needed?
fprintf(fid1,'ET,1,PLANE53\n');
fprintf(fid1,'MP,MURX,1,1\n');

% Draw air
fprintf(fid1,'RECTNG,');
fprintf(fid1,'%f',-a/2);
fprintf(fid1,',');
fprintf(fid1,'%f',a/2);
fprintf(fid1,',');
fprintf(fid1,'%f',-b/2);
fprintf(fid1,',');
fprintf(fid1,'%f',b/2);
fprintf(fid1,'\n');

% Draw outer 'cubes'
for i = 1:N
    if i == 1
        fprintf(fid1,'MP,MURX,');
        fprintf(fid1,'%f',i+1);
        fprintf(fid1,',1.05\n');
        fprintf(fid1,'MP,MGXX,');
        fprintf(fid1,'%f',i+1);
        fprintf(fid1,',');
        fprintf(fid1,'%f',h1);
        fprintf(fid1,'\n');

        fprintf(fid1,'LOCAL,');
        fprintf(fid1,'%f',10+i);
        fprintf(fid1,',0,');
        fprintf(fid1,'%f',((c+d)/2));
        fprintf(fid1,',0,0\n');
    else 
        fprintf(fid1,'MP,MURX,');
        fprintf(fid1,'%f',i+1);
        fprintf(fid1,',1.05\n');
        fprintf(fid1,'MP,MGXX,');
        fprintf(fid1,'%f',i+1);
        fprintf(fid1,',');
        fprintf(fid1,'%f',h1*cos((i-1)*(N/4+1)*theta));
        fprintf(fid1,'\n');
        fprintf(fid1,'MP,MGYY,');
        fprintf(fid1,'%f',i+1);
        fprintf(fid1,',');
        fprintf(fid1,'%f',h1*sin((i-1)*(N/4+1)*theta));
        fprintf(fid1,'\n');
        fprintf(fid1,'LOCAL,');
        fprintf(fid1,'%f',10+i);
        fprintf(fid1,',0,');
        fprintf(fid1,'%f',((c+d)/2)*cos((i-1)*theta));
        fprintf(fid1,',');
        fprintf(fid1,'%f',((c+d)/2)*sin((i-1)*theta));
        fprintf(fid1,',0,');
        fprintf(fid1,'%f',((i-1)*angle));
        fprintf(fid1,'\n');
    end
    fprintf(fid1,'WPCSYS,1,');
    fprintf(fid1,'%f',10+i);
    fprintf(fid1,'\n');
    fprintf(fid1,'RECTNG,');
    fprintf(fid1,'%f',-g/2);
    fprintf(fid1,',');
    fprintf(fid1,'%f',g/2);
    fprintf(fid1,',');
    fprintf(fid1,'%f',-g/2);
    fprintf(fid1,',');
    fprintf(fid1,'%f',g/2);
    fprintf(fid1,'\n');
    i = i+1;
end

% Draw inner 'cubes'
for i = 1:N
    if i == 1
        fprintf(fid1,'MP,MURX,');
        fprintf(fid1,'%f',i+1+N);
        fprintf(fid1,',1.05\n');
        fprintf(fid1,'MP,MGXX,');
        fprintf(fid1,'%f',i+1+N);
        fprintf(fid1,',');
        fprintf(fid1,'%f',h2);
        fprintf(fid1,'\n');
        
        fprintf(fid1,'LOCAL,');
        fprintf(fid1,'%f',10+i);
        fprintf(fid1,',0,');
        fprintf(fid1,'%f',((e+f)/2));
        fprintf(fid1,',0,0\n');
    else
        fprintf(fid1,'MP,MURX,');
        fprintf(fid1,'%f',i+1+N);
        fprintf(fid1,',1.05\n');
        fprintf(fid1,'MP,MGXX,');
        fprintf(fid1,'%f',i+1+N);
        fprintf(fid1,',');
        fprintf(fid1,'%f',h2*cos(-(i-1)*(N/4-1)*(theta)));
        fprintf(fid1,'\n');
        fprintf(fid1,'MP,MGYY,');
        fprintf(fid1,'%f',i+1+N);
        fprintf(fid1,',');
        fprintf(fid1,'%f',h2*sin(-(i-1)*(N/4-1)*(theta)));
        fprintf(fid1,'\n');
        
        fprintf(fid1,'LOCAL,');
        fprintf(fid1,'%f',10+i);
        fprintf(fid1,',0,');
        fprintf(fid1,'%f',((e+f)/2)*cos((i-1)*theta));
        fprintf(fid1,',');
        fprintf(fid1,'%f',((e+f)/2)*sin((i-1)*theta));
        fprintf(fid1,',0,');
        fprintf(fid1,'%f',((i-1)*angle));
        fprintf(fid1,'\n');
    end
    fprintf(fid1,'WPCSYS,1,');
    fprintf(fid1,'%f',10+i);
    fprintf(fid1,'\n');
    fprintf(fid1,'RECTNG,');
    fprintf(fid1,'%f',-k/2);
    fprintf(fid1,',');
    fprintf(fid1,'%f',k/2);
    fprintf(fid1,',');
    fprintf(fid1,'%f',-k/2);
    fprintf(fid1,',');
    fprintf(fid1,'%f',k/2);
    fprintf(fid1,'\n');
    i = i+1;
end

fprintf(fid1,'WPCSYS,1,0\n');          % Back to original working plane

% Assign material properties outer ring
for i = 1:N

    fprintf(fid1,'ASEL,S,AREA,,');
    fprintf(fid1,'%f',i+1);
    fprintf(fid1,'\n');
    fprintf(fid1,'AATT,');
    fprintf(fid1,'%f',i+1);
    fprintf(fid1,',,');
    fprintf(fid1,'%f',1);
    fprintf(fid1,'\n');

    i=i+1;
end

% Assign material properties inner ring
for i = 1:N
    fprintf(fid1,'ASEL,S,AREA,,');
    fprintf(fid1,'%f',i+1+N);
    fprintf(fid1,'\n');
    fprintf(fid1,'AATT,');
    fprintf(fid1,'%f',i+1+N);
    fprintf(fid1,',,');
    fprintf(fid1,'%f',1);
    fprintf(fid1,'\n');

    i = i+1;
end

fprintf(fid1,'ASEL,ALL\n');
fprintf(fid1,'ASBA,1,ALL,,,KEEP\n');
fprintf(fid1,'ASEL,U,AREA,,2,');
fprintf(fid1,'%f',2*N+1);
fprintf(fid1,'\n');
fprintf(fid1,'AATT,1,,1\n');

% Boundary conditions
fprintf(fid1,'ALLSEL\n');
fprintf(fid1,'LSEL,S,EXT\n');
fprintf(fid1,'DL,ALL,,AZ,0\n');

fprintf(fid1,'ALLSES\n');
fprintf(fid1,'AESIZE,ALL,');
fprintf(fid1,'%f',mesh);
fprintf(fid1,'\n');
fprintf(fid1,'AMESH,ALL\n');

% Apply force flags
fprintf(fid1,'ESEL,S,MAT,,2,');
fprintf(fid1,'%f',N+1);
fprintf(fid1,'\n');
fprintf(fid1,'CM,mag1,ELEM\n');
fprintf(fid1,'FMAGBC,');
fprintf(fid1,'%s',quote);
fprintf(fid1,'mag1');
fprintf(fid1,'%s',quote);
fprintf(fid1,'\n');

fprintf(fid1,'FINISH\n');
fprintf(fid1,'ALLSEL\n');
fprintf(fid1,'/SOL\n');
fprintf(fid1,'MAGSOLV\n');
fprintf(fid1,'FINISH\n');

fprintf(fid1,'CSYS,ARG1\n');
fprintf(fid1,'_NAME=ARG2\n');
fprintf(fid1,'FINI\n');

fprintf(fid1,'/POST1\n');
fprintf(fid1,'CM,CN,NODE\n');
fprintf(fid1,'NSEL,ALL\n');
fprintf(fid1,'*GET,NDMX,NODE,,NUM,MAX\n');
fprintf(fid1,'CMSEL,,CN\n');

fprintf(fid1,'*SET,_MSK\n');
fprintf(fid1,'*DIM,_MSK,,NDMX\n');
fprintf(fid1,'*VGET,_MSK(1),NODE,1,NSEL\n');
fprintf(fid1,'*VOPER,_MSK(1),_MSK(1),GT,0\n');
fprintf(fid1,'*SET,NODDAT\n');
fprintf(fid1,'*DIM,NODDAT,,NDMX,4\n');

fprintf(fid1,'*VMASK,_MSK(1)\n');
fprintf(fid1,'*VFILL,NODDAT(1,1),RAMP,1,1\n');
fprintf(fid1,'*VMASK,_MSK(1)\n');
fprintf(fid1,'*VGET,NODDAT(1,2),NODE,1,LOC,X\n');
fprintf(fid1,'*VMASK,_MSK(1)\n');
fprintf(fid1,'*VGET,NODDAT(1,3),NODE,1,LOC,Y\n');
fprintf(fid1,'*VMASK,_MSK(1)\n');
fprintf(fid1,'*VGET,NODDAT(1,4),NODE,1,B,SUM\n');

fprintf(fid1,'/NOPR\n');
fprintf(fid1,'/OUT,');
fprintf(fid1,'%s',quote);
fprintf(fid1,'NodeData');
fprintf(fid1,'%s',quote);
fprintf(fid1,',txt\n');

fprintf(fid1,'*VMASK,_MSK(1)\n');
fprintf(fid1,'*VWRITE,NODDAT(1),NODDAT(1,2),NODDAT(1,3),NODDAT(1,4)\n');
fprintf(fid1,'(E14.6,2X,E14.8,2X,E14.8,2X,E14.8)\n');
fprintf(fid1,'/OUT\n');
fprintf(fid1,'/GOPR\n');

% fprintf(fid1,'*UILI,');
% fprintf(fid1,'%s',quote);
% fprintf(fid1,'NodeData');
% fprintf(fid1,'%s',quote);
% fprintf(fid1,',txt\n');

fprintf(fid1,'/EOF\n');

% fprintf(fid1,'/POST1\n');
% fprintf(fid1,'PLF2D\n');
% fprintf(fid1,'fmagsum,');
% fprintf(fid1,'%s',semi);
% fprintf(fid1,'mag1');
% fprintf(fid1,'%s',semi);
% fprintf(fid1,'\n');
% 
% fprintf(fid1,'etab,fmgx1,fmag,x\n');
% fprintf(fid1,'etab,fmgy1,fmag,y\n');
% fprintf(fid1,'etab.fmgz1,fmag,z\n');
% 
% fprintf(fid1,'SSUM\n');
% 
% fprintf(fid1,'*dim,ff,ARRAY,4\n');
% fprintf(fid1,'*get,ff(1),ssum,fmx_x\n');
% fprintf(fid1,'*get,ff(2),ssum,fvw_x\n');
% fprintf(fid1,'*get,ff(3),ssum,fmx_y\n');
% fprintf(fid1,'*get,ff(4),ssum,fvw_y\n');

% fprintf(fid1,'NLIST,,,,,NODE,X,Y\n');

fclose(fid1);

% Run the ANSYS batch file, locations must be correct
!"C:\Program Files\ANSYS Inc\v140\ansys\bin\intel\ANSYS140" -b -i C:\magcode\ansys\halbach2d.txt -o C:\magcode\ansys\halbachresult.out

% Delete 'unnecessary' files
!del file.BCS
!del file.emat
!del file.err
!del file.esav
!del file.full
!del file.rmg
!del file.stat

% Run results reader and make scatter and contour plot
readAnsysHalbach();