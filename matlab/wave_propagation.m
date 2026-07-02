% Simulation of particle motion during the propagation of seismic waves
% v1.0.0
% Odysseus Galanis
% ogalanis.webpages.auth.gr
% Updated for Matlab R2025a in 2026
% License: GNU GPL v3
% 
% *Originally written in 2007 to produce images for
% https://web.archive.org/web/20071104224653/http://users.auth.gr/~ogalanis/el/articles/propagat
% and for https://phdtheses.ekt.gr/eadd/handle/10442/19795

clear;

% number of particles in each direction
ix=30;
iy=10;
iz=10;
% amplitude of the wave as a fraction of the spacing between particles
amp=0.9;
% wavenumber in 1/(spacing). This determines the velocity
k=0.8;
% simulate P or S waves
p_or_s = 'P';
%p_or_s='S';
% period in gif frames
period=20;
% velocity in (grid spacing) / (gif frame)
c=2*pi/(period*k);

figure;

% loop over gif frames
for t=1:period

  % coordinates of equilibrium position of particles.
  % do this for the visible surfaces only
  hold on;
  [x1,z1]=meshgrid(1:ix,1:iz);
  y1=ones(size(x1));
  [x2,y2]=meshgrid(1:ix,1:iy);
  z2=iz*ones(size(x2));
  [y3,z3]=meshgrid(1:iy,1:iz);
  x3=ix*ones(size(z3));

  % displacement of particles
  u1=amp*cos(k*(x1-c*t));
  u2=amp*cos(k*(x2-c*t));
  u3=amp*cos(k*(x3-c*t));

  % position of particles
  if (p_or_s=='P')
    x1=x1+u1;
    x2=x2+u2;
    x3=x3+u3;
  else
    z1=z1+u1;
    z2=z2+u2;
    z3=z3+u3;   
  end

  % draw the three visible outer surfaces
  h1=surface(x1,y1,z1,'FaceColor',[0 1 1],'EdgeColor','none');
  h2=surface(x2,y2,z2,'FaceColor',[0 1 1],'EdgeColor','none');
  h3=surface(x3,y3,z3,'FaceColor',[0 1 1],'EdgeColor','none');

  % draw the particles as small spheres
  for i=1:ix
    for j=1:iy
      [x0,y0,z0]=sphere;
      x0=0.3*x0+x2(j,i);
      y0=0.3*y0+y2(j,i);
      z0=0.3*z0+z2(j,i);
      surface(x0,y0,z0,'FaceColor',[1 0 0],'EdgeColor','none');
    end
  end

  for i=1:ix
    for j=1:iz
      [x0,y0,z0]=sphere;
      x0=0.3*x0+x1(j,i);
      y0=0.3*y0+y1(j,i);
      z0=0.3*z0+z1(j,i);
      surface(x0,y0,z0,'FaceColor',[1 0 0],'EdgeColor','none');
    end
  end

  for i=1:iy
    for j=1:iz
      [x0,y0,z0]=sphere;
      x0=0.3*x0+x3(j,i);
      y0=0.3*y0+y3(j,i);
      z0=0.3*z0+z3(j,i);
      surface(x0,y0,z0,'FaceColor',[1 0 0],'EdgeColor','none');
    end
  end

  % view, lighting etc.
  view(20,20);
  camproj('perspective');
  axis equal;
  axis off;
  axis vis3d;
  axis([0 ix+1 0 iy+1 0 iz+1]);

  camlight(0,30); 
  lighting gouraud;

  % properties of the three surfaces
  set(h1,'SpecularColorReflectance',0.6,'SpecularExponent',50,'AmbientStrength',0.5);
  set(h2,'SpecularColorReflectance',0.6,'SpecularExponent',50,'AmbientStrength',0.5);
  set(h3,'SpecularColorReflectance',0.6,'SpecularExponent',50,'AmbientStrength',0.5);

  % capture frame from figure window and convert to image
  F(t)=getframe(gcf);
  [rgbimg, map] = frame2im(F(t));
  [img, cmap] = rgb2ind(rgbimg,256);

  % save images (frames) in gif file
  if (t==1)
    imwrite(img, cmap, "wave.gif", 'gif', 'Loopcount', inf, 'DelayTime', 0.1);
  else
    imwrite(img, cmap, "wave.gif", 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);
  end

  % clear figure
  clf;

end


