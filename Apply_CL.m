function [bm,cm,acc,Y]=Apply_CL(Tr,Ts,T,Options,TypeCL,Settings)
    if(isequal(TypeCL,'SVM')),[bm,cm,acc,Y]=Apply_SVM(Tr,Ts,T,Options); 
        elseif(isequal(TypeCL,'LDA')),[bm,cm,acc,Y]=Apply_LDA(Tr,Ts,Options); 
        elseif(isequal(TypeCL,'ELM')),[bm,cm,acc,Y]=Apply_ELM(Tr,Ts,Options,Settings);
        elseif(isequal(TypeCL,'Perceptron')),[bm,cm,acc,Y]=Apply_Perceptron(Tr,Ts,Options,Settings);
        elseif(isequal(TypeCL,'Perceptron2')),[bm,cm,acc,Y]=Apply_Perceptron2(Tr,Ts,Options,Settings);
        elseif(isequal(TypeCL,'NewPercptron')),[bm,cm,acc,Y]=Apply_NewPerceptron(Tr,Ts);
    end
end

function [bm,cm,acc,Y]=Apply_SVM(Tr,Ts,T,Options)  
    ts.T=Ts.T;
    Tr.P=Tr.P';
    Ts.P=Ts.P';
    Tr.T=vec2ind(Tr.T)';
    Ts.T=vec2ind(Ts.T)';        
    % Create a Model by training the SVM with specified Options
    SVMStruct = svmtrain(Tr.T,Tr.P,Options);
    % Test the trained Model on Training Data
    [predictions,~,~] = svmpredict(Ts.T, Ts.P, SVMStruct); 
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
    bmm=bookmaker(cm);
    bm=bmm.bookmaker;
end

function [bm,cm,acc,Y]=Apply_LDA(Tr,Ts,Options)
Tr.T=Tr.T';
Ts.T=Ts.T';
Tr.P=Tr.P';
Ts.P=Ts.P';
[cm,~,Y,~]=LDA_Func(Tr,Ts,Options);
acc = sum(diag(cm)) / sum(cm(:));
bmm=bookmaker(cm);
bm=bmm.bookmaker;
end


function [bm,cm,acc,Y]=Apply_ELM(Tr,Ts,Op,Settings)
% Tr.T=Tr.T';
% Ts.T=Ts.T';
% Tr.P=Tr.P';
% Ts.P=Ts.P';
%    [Tr.P,ps]=mapminmax(Tr.P);
%    Ts.P=mapminmax('apply',Ts.P,ps);
   Elm_Type=1;%classification
   NumberofHiddenNeurons=Settings.Node;
%     ActivationFunction='radbas';
    ActivationFunction=Op ;
%     ActivationFunction='sin';
%     ActivationFunction='sig';
%    ActivationFunction='hardlim';
% 'sig' for Sigmoidal function
% 'sin' for Sine function
% 'hardlim' for Hardlim function
% 'tribas' for Triangular basis function
% 'radbas' for Radial basis function (for additive type of SLFNs instead of RBF type of SLFNs)
   [trainrec.TrainingTime,trainrec.TestingTime,trainrec.TrainingAccuracy,trainrec.TestingAccuracy,~,Y]=ELM(Tr,Ts,Elm_Type, NumberofHiddenNeurons, ActivationFunction);   
   cm = full(compet(Y)*compet(Ts.T)');
   acc = sum(diag(cm)) / sum(cm(:));
    bmm=bookmaker(cm);
    bm=bmm.bookmaker;
end


function [bm,cm,acc,Y]=Apply_NewPerceptron(Tr,Ts)
[Y,cm,acc,bm,~,~,~,~,~]=perceptron2(Tr,Ts);
end

function [bm,cm,acc,Y]=Apply_Perceptron(Tr,Ts,Op,Settings)
%        NET = newp(P,T,TF,LF) takes these inputs,
%        P  - RxQ matrix of Q1 representative input vectors.
%        T  - SxQ matrix of Q2 representative target vectors.
%        TF - Transfer function, default = 'hardlim'.
%        LF - Learning function, default = 'learnp'.
 net = newp(Tr.P,Tr.T,Op,Settings.Learn); 
 net.trainParam.showWindow = false;
 net.trainParam.epochs = 20;
 net=train(net,Tr.P,Tr.T);
 Y=sim(net,Ts.P);
 cm = full(compet(Y)*compet(Ts.T)');
 acc = sum(diag(cm)) / sum(cm(:));
 bmm=bookmaker(cm);
 bm=bmm.bookmaker;
end


function [bm,cm,acc,Y]=Apply_Perceptron2(Tr,Ts,Op,Settings)
  Elm_Type=1;%classification
  NumberofHiddenNeurons=Settings.Node;
  ActivationFunction=Op ;
  [trainrec.TrainingTime,trainrec.TestingTime,trainrec.TrainingAccuracy,trainrec.TestingAccuracy,~,Y]=ELM2(Tr,Ts,Elm_Type, NumberofHiddenNeurons, ActivationFunction);   
  cm = full(compet(Y)*compet(Ts.T)');
  acc = sum(diag(cm)) / sum(cm(:));
  bmm=bookmaker(cm);
  bm=bmm.bookmaker;
end