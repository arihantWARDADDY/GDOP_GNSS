% Scenario 5 : Urban Canyon Simulation for GDOP

% Define satellite positions (in ECEF coordinates)
satPositions = [
    20000000, 5000000, 10000000;   % Satellite 1
    -10000000, 15000000, 20000000; % Satellite 2
    -15000000, -10000000, 25000000; % Satellite 3
    5000000, -20000000, 15000000;   % Satellite 4
    0, 0, 26000000;                 % Satellite 5 (zenith)
];

% Define receiver position (in ECEF coordinates)
receiverPosition = [0, 0, 0]; % Receiver at the origin

% Simulate urban canyon effects by modifying satellite visibility
% For simplicity, we will simulate that some satellites are blocked
blockedSatellites = [1, 3]; % Example: Satellites 1 and 3 are blocked

% Calculate GDOP considering only visible satellites
visibleSatPositions = satPositions;
visibleSatPositions(blockedSatellites, :) = []; % Remove blocked satellites

% Ensure at least four satellites are available
if size(visibleSatPositions, 1) < 4
    disp('Not enough visible satellites. Adding additional satellites.');
    % Add more satellites to ensure at least four are available
    additionalSatellites = [
        -20000000, -5000000, 10000000; % Additional Satellite A
        15000000, -15000000, 20000000; % Additional Satellite B
    ];
    visibleSatPositions = [visibleSatPositions; additionalSatellites(1:4-size(visibleSatPositions,1), :)];
end

% Calculate GDOP with the available visible satellites
gdop = calculateGDOP(visibleSatPositions, receiverPosition);

% Display the result
disp(['GDOP considering urban canyon effects: ', num2str(gdop)]);

% Visualize the scenario
visualizeUrbanCanyon(satPositions, receiverPosition, blockedSatellites, gdop);

function gdop = calculateGDOP(satPositions, receiverPosition)
    if size(satPositions, 1) < 4
        error('At least 4 satellites are required for GDOP calculation.');
    end
    
    los = satPositions - receiverPosition;
    los = los ./ vecnorm(los, 2, 2);
    
    G = [los, ones(size(los, 1), 1)];
    
    [~, S, ~] = svd(G);
    
    gdop = sqrt(sum(1 ./ diag(S).^2));
end

function visualizeUrbanCanyon(satPositions, receiverPosition, blockedSatellites, gdop)
    figure;
    
    % Plot all satellites
    scatter3(satPositions(:,1), satPositions(:,2), satPositions(:,3), 'r', 'filled');
    hold on;
    
    % Highlight blocked satellites
    scatter3(satPositions(blockedSatellites,1), satPositions(blockedSatellites,2), satPositions(blockedSatellites,3), 'k', 'filled');
    
    % Plot receiver position
    scatter3(receiverPosition(1), receiverPosition(2), receiverPosition(3), 'b', 'filled', 'MarkerFaceColor', 'b');
    
    % Draw lines from receiver to visible satellites
    for i = setdiff(1:size(satPositions, 1), blockedSatellites)
        plot3([receiverPosition(1), satPositions(i,1)], ...
              [receiverPosition(2), satPositions(i,2)], ...
              [receiverPosition(3), satPositions(i,3)], 'k--');
    end
    
    title(['Urban Canyon Simulation (GDOP: ', num2str(gdop), ')']);
    xlabel('X position (m)');
    ylabel('Y position (m)');
    zlabel('Z position (m)');
    legend('Visible Satellites', 'Blocked Satellites', 'Receiver', 'Location', 'best');
    
    grid on;
    axis equal;
end