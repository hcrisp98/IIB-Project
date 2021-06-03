
[rows, cols] = size(ZZ);
fallingID = NaN(size(ZZ));
removeID = NaN([rows 1]);
isoWindow = 3;

for balloon = 1:cols
    for t=1:rows
        
            radMax = sqrt(XX(t,balloon).^2+YY(t,balloon).^2);
            cutoff = max([(radMax-X0)*tan(ConeAngle) + Y0, Y0]);
            if ZZ(t,balloon)<cutoff && VZ(t,balloon) >0 
                td=t;
                
                try
                while mean(VZ((td-50):td,balloon))<0  || ZZ(td,balloon)<cutoff || mean(VZ(td,balloon))<0
                    fallingID(td,balloon)=1;
                    td = td-1;
                    radMax = sqrt(XX(td,balloon).^2+YY(td,balloon).^2);
                    cutoff = max([(radMax-X0)*tan(ConeAngle) + Y0 Y0]);
                end
                catch
                end
                
                
               td=t;
               radMax = sqrt(XX(td,balloon).^2+YY(td,balloon).^2);
               cutoff = max([(radMax-X0)*tan(ConeAngle) + Y0 Y0]);
                
               try
                while VZ(td,balloon)>0  || ZZ(td,balloon)<cutoff 
                    fallingID(td,balloon)=1;
                    td = td+1;
                    radMax = sqrt(XX(td,balloon).^2+YY(td,balloon).^2);
                    cutoff = max([(radMax-X0)*tan(ConeAngle) + Y0 Y0]);
                    removeID(td) = 1;
                end
               catch
               end
                
                
            end
    end
end

ZFalling = ZZ.*fallingID;
XFalling = XX.*fallingID;
YFalling = YY.*fallingID;
