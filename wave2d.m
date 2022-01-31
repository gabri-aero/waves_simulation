function [] = wave2d(L,t,h,dt)
    % wave2d(1,1,1e-2,1e-4)
    n=t/dt;
    mx=L/h;
    my=L/h;
    %f=@(x,y) sin(pi.*x).*sin(pi.*y);
    f=@(x,y) exp(-100*(x-0.5).^2).*exp(-100*(y-0.5).^2);
    x=0:h:L;
    y=0:h:L;
    [X,Y]=meshgrid(x,y);
    u0=f(X,Y);
    u=zeros(mx+1,my+1,n+1);
    u(:,:,1)=u0;
    % Inicio
    for i=2:mx
        for j=2:my
            u(i,j,2)=(u(i+1,j,1)+u(i-1,j,1)+u(i,j+1,1)+u(i,j-1,1)-4.*u(i,j,1)).*dt^2./(h^2)+u(i,j,1);
        end
    end
    for k=2:1:n
        for i=2:mx
            for j=2:my
                u(i,j,k+1)=100.*(u(i+1,j,k)+u(i-1,j,k)+u(i,j+1,k)+u(i,j-1,k)-4.*u(i,j,k)).*dt^2./(h^2)+2*u(i,j,k)-u(i,j,k-1);
            end
        end
        uk=u(:,:,k+1);
        u(:,:,k+1)=uk;
        disp(k)
    end
    %% Initialize video
    myVideo = VideoWriter('prueba2'); %open video file
    myVideo.FrameRate = 10;  %can adjust this, 5 - 10 works well for me
    open(myVideo)
    for k=1:10:n
        s=surf(X,Y,u(:,:,k));
        s.EdgeColor='none'; 
        zlim([-1 1])
        drawnow
        frame = getframe(gcf); %get frame
        writeVideo(myVideo, frame);
    end
end