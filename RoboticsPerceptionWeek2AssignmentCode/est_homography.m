function [ H ] = est_homography(video_pts, logo_pts)
% est_homography estimates the homography to transform each of the
% video_pts into the logo_pts
% Inputs:
%     video_pts: a 4x2 matrix of corner points in the video
%     logo_pts: a 4x2 matrix of logo points that correspond to video_pts
% Outputs:
%     H: a 3x3 homography matrix such that logo_pts ~ H*video_pts
% Written for the University of Pennsylvania's Robotics:Perception course

% YOUR CODE HERE
% construction of matrix A by 4 vectors like [a_x a_y]
% video_pts as X, logo_pts as X'
% the size of A_x, A_y are both 4*9, A is 8*9
% % Test: est_homography([0 0; 1 0; 0 1; 1 1], [1 1; 2 1; 1 2; 2 2])
% A_x = [-[video_pts ones(4,1)], zeros(4,3),  [video_pts ones(4,1)].*repmat(logo_pts(:,1), 1, 3)];
% A_y = [zeros(4,3), -[video_pts ones(4,1)],  [video_pts ones(4,1)].*repmat(logo_pts(:,2), 1, 3)];
% A = [A_x; A_y];
% % A = [A_y; A_x];
% A = A([1 5 2 6 3 7 4 8], :);
% [U, S, V]= svd(A);
% h = V(:,end)';
% % normalization
% % h = h/h(end);
% H = [h(1:3); h(4:6); h(7:9)];


X = logo_pts(:,1)
Y = logo_pts(:,2)
x = video_pts(:,1)
y = video_pts(:,2)
A = zeros(length(x(:))*2,9);

for i = 1:length(x(:)),
 a = [x(i),y(i),1];
 b = [0 0 0];
 c = [X(i);Y(i)];
 d = -c*a;
 A((i-1)*2+1:(i-1)*2+2,1:9) = [[a b;b a] d];
end

[U S V] = svd(A);
h = V(:,9);
H = reshape(h,3,3)'

end

