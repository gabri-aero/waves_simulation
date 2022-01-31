function [] = double_slit(sep, w)
    % L is the width of the area of study
    % t time of expmeriment
    % dt, h discretization intervals
    L=1; t=0.3; h=1e-2; dt=1e-4;
    %sep=0.03;
    %w=0.03;
    n=t/dt;
    mx=5*L/h;
    my=5*L/h;
    %f=@(x,y) sin(pi.*x).*sin(pi.*y);
    f=@(x,y) exp(-10000*x.^2).*exp(-10000*y.^2); % INITIAL CONDITION
    x=-0.5*5*L:h:0.5*5*L;
    y=-0.5*5*L:h:0.5*5*L;
    [X,Y]=meshgrid(x,y); % spatial mesh definition
    u0=f(X,Y);
    u=zeros(mx+1,my+1,n+1);
    u(:,:,1)=u0;
    % Initialization
    flag=[(Y<-sep/2-w | Y>sep/2+w | (Y<sep/2 & Y>-sep/2)) & (X==1)]; % double slit
    for i=2:mx
        for j=2:my
            u(i,j,2)=100.*(u(i+1,j,1)+u(i-1,j,1)+u(i,j+1,1)+u(i,j-1,1)-4.*u(i,j,1)).*dt^2./(h^2)+u(i,j,1);
        end % first iteration
    end
    for k=2:1:n % general iterations
        for i=2:mx
            for j=2:my
                u(i,j,k+1)=100.*(u(i+1,j,k)+u(i-1,j,k)+u(i,j+1,k)+u(i,j-1,k)-4.*u(i,j,k)).*dt^2./(h^2)+2*u(i,j,k)-u(i,j,k-1);
            end
        end
        uk=u(:,:,k+1);
        uk(flag)=0;
        u(:,:,k+1)=uk;
        disp(k)
    end
    % ZOOM TO AREA OF STUDY
    uplot=u(0.4*my:0.6*my,0.4*mx:0.9*mx,:); 
    xplot=X(0.4*my:0.6*my,0.4*mx:0.9*mx);
    yplot=Y(0.4*my:0.6*my,0.4*mx:0.9*mx);
    %% Initialize video
    figure('units','pixels','position',[0 0 1440 1080])
    myVideo = VideoWriter('double_slit'); %open video file
    myVideo.FrameRate = 20;  %can adjust this, 5 - 10 works well for me
    open(myVideo)
    % Plotting saved data
    for k=1:10:n
        hold off
        maxvalue=max(uplot(:,end,:),[],'all');
        plot3(xplot(:,end),yplot(:,end),uplot(:,end,k)/maxvalue);
        title('Double slit experiment')
        hold on
        grid on
        s=surf(xplot,yplot,uplot(:,:,k));
        s.EdgeColor='none'; 
        zlim([-1 1])
        ylim([-0.5 0.5])
        xlim([0 xplot(1,end)])
        daspect([1 1 3])
        plot3([1 1],[-sep/2-w -1],[0 0],'r')
        plot3([1 1],[sep/2+w 1],[0 0],'r')
        plot3([1 1],[sep/2 -sep/2],[0 0],'r')
        plot3([xplot(1,end) xplot(1, end)],[-1 1],[0 0],'b')
        drawnow
        frame = getframe(gcf); %get frame
        writeVideo(myVideo, frame);
    end
end