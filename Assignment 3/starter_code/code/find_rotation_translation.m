function [R, t] = find_rotation_translation(E)
    t = cell(2,1);
    R = cell(1);

    [U,S,V] = svd(E);
    t{1} = U(:,3);
    t{2} = -U(:,3);

    idx = 1;
    rot = [0,-1,0;1,0,0;0,0,1];
    r1 = U * rot' * V';
    if det(r1) > 0
        R{idx} = r1;
        idx = idx + 1;
    end
    
    r2 = -U * rot' * V';
    if det(r2) > 0
        R{idx} = r2;
        idx = idx + 1;
    end
    
    r3 = U * inv(rot)' * V';
    if det(r3) > 0
        R{idx} = r3;
        idx = idx + 1;
    end
    
    r4 = -U * inv(rot)' * V';
    if det(r4) > 0
        R{idx} = r4;
        idx = idx + 1;
    end
end

