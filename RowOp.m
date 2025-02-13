function X=RowOp(M,debug)
    X=M;
    [m,n]=size(X);
    k=min([m,n]);
    for i=1:k
        % normalize diagonal element
        coef=X(i,i);
        X(i,:)=X(i,:)/coef;
        % nullify column under the element
        for j=i+1:k
            X(j,:)=X(j,:)-X(j,i)*X(i,:);
            if debug
                disp(X)
            end
        end
    end
    if ~isempty(k+1:m)
        X(k+1:m,:)=X(k+1:m,:)*0;
    end
end