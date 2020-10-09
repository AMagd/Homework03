% Author ~ Ahmed Magd Aly
% Innopolis University

function O = FK(theta1, theta2, d3, enable_plot)
% Forward Kinematics Function:

d1 = 175;
a2 = 250;

theta1 = deg2rad(theta1);
theta2 = deg2rad(theta2);

%% Origin Frame
O0 = eye(4); % world reference frame

O1 = Rz(theta1)*Tz(d1);

O2 = O1*Ry(-theta2)*Tx(a2);

O3 = O2*Tx(d3);

O = round([O0, O1, O2, O3],10);

global axes_plot links_plot joints_plot end_effector_plot plane_plot

if enable_plot
    % figure('units','normalized','outerposition',[0 0 1 1])
    


    as = 150; % axes scaler
    color = ['r','g','b']; % axes color
    
    index = 0;
    for i = 1:4:length(O)
        index = index + 1;
        points_x(index) = O(1,i+3);
        points_y(index) = O(2,i+3);
        points_z(index) = O(3,i+3);
        
        for axes = 0:2
            axes_plot = [axes_plot plot3([O(1,i+3) as*O(1,i+axes)+O(1,i+3)], [O(2,i+3) as*O(2,i+axes)+O(2,i+3)], [O(3,i+3) as*O(3,i+axes)+O(3,i+3)],'Color',color(axes+1))];
            hold on
        end
    end
    joints_x = points_x;
    joints_y = points_y;
    joints_z = points_z;
    
    links_plot = [links_plot plot3(points_x, points_y, points_z,'Color', "0 0 0",'linewidth',2)];
    hold on
    joints_plot = [joints_plot plot3(joints_x(1:3), joints_y(1:3), joints_z(1:3),'.','Color','0.992 0.788 0.04 1','MarkerSize',20)];
    hold on
    end_effector_plot = [end_effector_plot plot3(joints_x(4), joints_y(4), joints_z(4),'.','Color','0.8 0 0 1','MarkerSize',20)];
    path_plot = plot3(joints_x(4), joints_y(4), joints_z(4),'.','Color','0.8 0 0 1','MarkerSize',7.5);
    
%     xlim([-750 750])
%     ylim([-750 750])
%     zlim([-100 1000])
%     view(0,0)
    grid on
    xlabel("x-axis")
    ylabel("y-axis")
    zlabel("z-axis")
    
    [x_plane, y_plane] = meshgrid( [0, O(1,size(O,2))], [0, O(2,size(O,2))]);
    z_plane = x_plane*0;
    plane_plot = surf(x_plane, y_plane, z_plane,'FaceAlpha', .3);
    colormap([0.1 0.1 0.1])
end


