% This function connects two axon segments 
function result = connect_segment(ang_limit, dis_limit, data, pos, Wa, Wb, Wd)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% ang_limit: limit angle of the connection
% dis_limit: limit distance of the connection
% data: image with segments wanted to be connected 
% pos: positions of end points
% Wa: weight of theta12
% Wb: weight of theta23
% Wd: weight of dis

temp1 = data(pos(1,2)- 1: pos(1,2) + 1, pos(1,1)- 1: pos(1,1) + 1);
temp1(2,2) = 0;
[x1,y1] = find(temp1 == 1);
v1 = [2,2] - [x1,y1];

v2 = [pos(2,2) - pos(1,2), pos(2,1) - pos(1,1)];
% test_result = connect(test_img, 73,124,84,159);

temp2 = data(pos(2,2)- 1: pos(2,2) + 1, pos(2,1)- 1: pos(2,1) + 1);
temp2(2,2) = 0;
[x2,y2] = find(temp2 == 1);
v3 = [x2,y2] - [2,2];

% v1 & v2 angle
theta12 = abs(acos(dot(v1,v2)/(norm(v1) * norm(v2))));
% v2 % v3 angle
theta23 = abs(acos(dot(v2,v3)/(norm(v2) * norm(v3))));
% distance
dis = norm(v2);
% if all satistfied
cost = Wa*theta12/ang_limit + Wb*theta23/ang_limit + Wd*dis/dis_limit;

if cost < 1  
    % use the connect function to connect 2 end points
    result = connect(data, pos(1,1), pos(1,2), pos(2,1), pos(2,2));
else 
    result = data;
end

end

