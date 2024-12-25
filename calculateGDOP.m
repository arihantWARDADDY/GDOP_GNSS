function gdop = calculateGDOP(satPositions, receiverPosition)
    los = satPositions - receiverPosition;
    los = los ./ vecnorm(los, 2, 2);
    G = [los, ones(size(los, 1), 1)];
    Q = inv(G' * G);
    gdop = sqrt(trace(Q));
end