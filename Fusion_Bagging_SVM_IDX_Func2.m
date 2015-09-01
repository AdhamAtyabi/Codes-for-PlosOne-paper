%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB Code for                                                  %
%                                                                   %
%  Bagging experiments using LIBSVM implementation                  %
%  of support vectyor machine                                       %
%  Version 1.0 - Aug. 2015                                          %
%                                                                   %
%  According to:                                                    %
%  H.R. Tavakoli, A. Atyabi, Antti Rantanen, Seppo J. Laukka,       %
%  Samia Nefti-Meziani, & Janne Heikkilä,                           %
%  "Predicting the valence of a scene from observers' eye movements"%
%  PLOS ONE, 2015.                                                  %
%                                                                   %
%                                                                   %
%  Programmed By: A. Atyabi                                         %
%                                                                   %
%         e-Mail: a.atyabi@salford.ac.uk                            %
%                 adham.atyabi@flinders.edu.au                      %
%                                                                   %
% Homepage: http://www.seek.salford.ac.uk/profiles/AAtyabi.jsp      %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[bm,cm,acc,Y,idx]=Fusion_Bagging_SVM_IDX_Func2(idx,P,T,traindex,testindex,fold,CL_Obj,svd_sw)
    Tr.P=P(:,traindex{fold});    
    Tr.T=T(:,traindex{fold});
    Ts.P=P(:,testindex{fold});
    Ts.T=T(:,testindex{fold}); 
    if(isempty(idx))
        sw=1;
        while(sw==1)
            idx=randi(size(Tr.P,2),1,size(Tr.P,2));
            T2=Tr.T(:,idx);
            if(sum(T2(1,:))==sum(T2(2,:))&&sum(T2(1,:))==sum(T2(3,:))&&sum(T2(3,:))==sum(T2(2,:)))
                sw=0;
            end
        end
    end
    Tr.P=Tr.P(:,idx);
    Tr.T=Tr.T(:,idx);
%     if(isequal(svd_sw,1))
%         [Tr,Ts]=SVD_Func(Tr,Ts);
%     end;
    ts.T=Ts.T;
    Tr.P=Tr.P';
    Ts.P=Ts.P';
    Tr.T=vec2ind(Tr.T)';
    Ts.T=vec2ind(Ts.T)';
    % Create a Model by training the SVM with specified Options
    SVMStruct = svmtrain(Tr.T,Tr.P,CL_Obj.Extra);
    % Test the trained Model on Training Data
    predictions = svmpredict(Ts.T, Ts.P, SVMStruct);
    Y=zeros(size(T,1),size(predictions,1));
    for  t=1:size(T,1)
    for r=1:size(predictions,1)
        if (isequal(predictions(r),t)~=0)
            for o=1:size(Ts.T,1)
                 Y(t,r)=1;
            end
        end
    end
    end
    cm = full(compet(Y)*compet(ts.T)');
    acc = sum(diag(cm)) / sum(cm(:));
    bm=bookmaker(cm);
end
