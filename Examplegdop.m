
% Improved satellite positions for better geometry
satPositions = [
    26000000, 0, 0;
    -13000000, 22516660, 0;
    -13000000, -22516660, 0;
    0, 0, 26000000;
    20000000, 15000000, 10000000;
    -20000000, -15000000, 10000000
];

% Example receiver position (1x3 vector representing x, y, z coordinates)
receiverPosition = [0, 0, 0];

% Call the function with the required arguments
gdop = calculateGDOP(satPositions, receiverPosition);

% Display the result
disp(['GDOP: ', num2str(gdop)]);

% Create a 3D plot
figure;
scatter3(satPositions(:,1), satPositions(:,2), satPositions(:,3), 100, 'filled', 'MarkerFaceColor', 'r');
hold on;
scatter3(receiverPosition(1), receiverPosition(2), receiverPosition(3), 100, 'filled', 'MarkerFaceColor', 'b');

% Draw lines from receiver to satellites
for i = 1:size(satPositions, 1)
    plot3([receiverPosition(1), satPositions(i,1)], ...
          [receiverPosition(2), satPositions(i,2)], ...
          [receiverPosition(3), satPositions(i,3)], 'k--');
end

% Customize the plot
title(['Satellite and Receiver Positions (GDOP: ', num2str(gdop), ')']);
xlabel('X position (m)');
ylabel('Y position (m)');
zlabel('Z position (m)');
legend('Satellites', 'Receiver', 'Location', 'best');
grid on;
axis equal;
view(45, 30);

% Function to calculate GDOP
function gdop = calculateGDOP(satPositions, receiverPosition)
    % Ensure we have at least 4 satellites
    if size(satPositions, 1) < 4
        error('At least 4 satellites are required for GDOP calculation.');
    end
    
    % Calculate unit vectors from receiver to satellites
    los = satPositions - receiverPosition;
    los = los ./ vecnorm(los, 2, 2);
    
    % Form the geometry matrix
    G = [los, ones(size(los, 1), 1)];
    
    % Use SVD for a more stable computation
    [~, S, ~] = svd(G);
    
    % Calculate GDOP using the singular values
    gdop = sqrt(sum(1 ./ diag(S).^2));
    
    % Check for unreasonably large GDOP values
    if gdop > 6
        warning('GDOP value is higher than ideal. Consider improving satellite geometry.');
    end
end