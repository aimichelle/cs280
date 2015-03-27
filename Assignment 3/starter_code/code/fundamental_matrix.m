function [F, res_err] = fundamental_matrix(matches)
    % Normalization
    t1_add = [1,0; 0,1; -mean(matches(:,1:2))];
    t2_add = [1,0; 0,1; -mean(matches(:,3:4))];
    p1_cent = [matches(:,1:2) ones(size(matches, 1), 1)]*t1_add;
    p2_cent = [matches(:,3:4) ones(size(matches, 1), 1)]*t2_add;
    p1_scale = sqrt(2)/mean(sqrt(p1_cent(:,1:1).^2 + p1_cent(:,2:2).^2));
    p2_scale = sqrt(2)/mean(sqrt(p2_cent(:,1:1).^2 + p2_cent(:,2:2).^2));
    t1 = [p1_scale,0; 0,p1_scale; -p1_scale*mean(matches(:,1:2))];
    t2 = [p2_scale,0; 0,p2_scale; -p2_scale*mean(matches(:,1:2))];
    p1 = [matches(:,1:2) ones(size(matches, 1), 1)]*t1;
    p2 = [matches(:,3:4) ones(size(matches, 1), 1)]*t2;
    
    % Optimization
    % Create A from our normalized matching points
    % There is probably a better way to do this, but I suck with matrices
    A =  zeros(size(matches, 1), 9);
    for n = 1:size(matches, 1)
        A(n,:) = reshape(transpose([p1(n,:), 1])*[p2(n,:), 1], 1, 9);
    end
    % Use SVD to find approximate solution
    [U1,S1,V1] = svd(transpose(A));
    f = reshape(U1(:, 9), 3, 3);
    [U2, S2, V2] = svd(f);
    F = U2 * [S2(1,:);S2(2,:);0,0,0] * V2;
    
    % Denormalization
    t1 = [p1_scale,0,0; 0,p1_scale,0; -p1_scale*mean(matches(:,1:2)),1];
    t2 = [p2_scale,0,0; 0,p2_scale,0; -p2_scale*mean(matches(:,1:2)),1];
    F = t2*F*t1';
    
    % Find residual
    epi1 = transpose(F*[matches(:,1:2) ones(size(matches, 1), 1)]');
    epi2 = transpose(F*[matches(:,3:4) ones(size(matches, 1), 1)]');
    %epi2 = matches(:,3:4)*F;
    res_err = mean([(epi1(:,1) - matches(:,1:1)).^2 + (epi1(:,2) - matches(:,2:2)).^2 +  (epi1(:,3) - 1).^2; (epi2(:,1) - matches(:,3:3)).^2 + (epi2(:,2) - matches(:,4:4)).^2 + (epi2(:,3) - 1).^2]);
    
end