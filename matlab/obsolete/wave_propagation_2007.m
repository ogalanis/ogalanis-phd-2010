
clear;

ix=30;
iy=10;
iz=10;
amp=0.9;
k=0.8;
p_or_s='S';
period=20;
c=2*pi/(period*k);

figure;

t=1;

%for t=1:period

hold on;
[x1,z1]=meshgrid(1:ix,1:iz);
y1=ones(size(x1));
[x2,y2]=meshgrid(1:ix,1:iy);
z2=iz*ones(size(x2));
[y3,z3]=meshgrid(1:iy,1:iz);
x3=ix*ones(size(z3));

u1=amp*cos(k*(x1-c*t));
u2=amp*cos(k*(x2-c*t));
u3=amp*cos(k*(x3-c*t));

if (p_or_s=='P')
  x1=x1+u1;
  x2=x2+u2;
  x3=x3+u3;
else
  z1=z1+u1;
  z2=z2+u2;
  z3=z3+u3;   
end


h1=surface(x1,y1,z1,25*ones(size(z1)),'EdgeColor',[0 0 0],'CDataMapping','direct');
h2=surface(x2,y2,z2,25*ones(size(z2)),'EdgeColor',[0 0 0],'CDataMapping','direct');
h3=surface(x3,y3,z3,25*ones(size(z3)),'EdgeColor',[0 0 0],'CDataMapping','direct');


for i=1:ix
  for j=1:iy
    [x0,y0,z0]=sphere;
    x0=0.3*x0+x2(j,i);
    y0=0.3*y0+y2(j,i);
    z0=0.3*z0+z2(j,i);
    surface(x0,y0,z0,60*ones(size(z0)),'EdgeColor',[0 0 0],'CDataMapping','direct');
  end
end

for i=1:ix
  for j=1:iz
    [x0,y0,z0]=sphere;
    x0=0.3*x0+x1(j,i);
    y0=0.3*y0+y1(j,i);
    z0=0.3*z0+z1(j,i);
    surface(x0,y0,z0,60*ones(size(z0)),'EdgeColor',[0 0 0],'CDataMapping','direct');
  end
end

for i=1:iy
  for j=1:iz
    [x0,y0,z0]=sphere;
    x0=0.3*x0+x3(j,i);
    y0=0.3*y0+y3(j,i);
    z0=0.3*z0+z3(j,i);
    surface(x0,y0,z0,60*ones(size(z0)),'EdgeColor',[0 0 0],'CDataMapping','direct');
  end
end


%annotation('arrow',[0.3 0.7],[0.25 0.17],'LineWidth',3,...
%'HeadStyle','plain','HeadWidth',20,'HeadLength',20);
%text((2/3)*ix,-10,0,'äéåýèõíóç äéÜäïóçò êýìáôïò','FontName','Arial Unicode MS',...
%    'FontSize',14,'HorizontalAlignment','center','Rotation',0);

%if (p_or_s=='P')
%annotation('doublearrow',[0.4 0.6],[0.805 0.77],'LineWidth',3,...
%'HeadStyle','plain','HeadWidth',10,'HeadLength',15);
%else
%annotation('doublearrow',[0.5 0.5],[0.9 0.7],'LineWidth',3,...
%'HeadStyle','plain','HeadWidth',10,'HeadLength',15);  
%end


%text((3/4)*ix,10,14,'äéåýèõíóç êßíçóçò õëéêïý óçìåßïõ','FontName','Arial Unicode MS',...
%    'FontSize',8,'HorizontalAlignment','center','Rotation',0);

view(20,20);
camproj('perspective');
axis equal;
axis off;
axis vis3d;
axis([0 ix+1 0 iy+1 0 iz+1]);

lightangle(0,30);
set(gcf,'Renderer','zbuffer');
lighting phong;
shading interp;

set(h1,'AmbientStrength',0.5);
set(h2,'AmbientStrength',0.5);
set(h3,'AmbientStrength',0.5);

set(h1,'SpecularColorReflectance',0.6,'SpecularExponent',50);
set(h2,'SpecularColorReflectance',0.6,'SpecularExponent',50);
set(h3,'SpecularColorReflectance',0.6,'SpecularExponent',50);

%F(t)=getframe(gcf);

%clf;

%end

%movie2avi(F(2:20),'test.avi','compression','Cinepak');
