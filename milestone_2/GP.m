clc;clear
% load ('C:\Users\user0630\OneDrive - Washington University in St. Louis\2018 Spring\Machine Learning\Application Project\CSE517a_Application_Project.git\trunk\milestone_1\data.mat')
load ('C:\Users\Yao-Chi\OneDrive - Washington University in St. Louis\2018 Spring\Machine Learning\Application Project\CSE517a_Application_Project.git\trunk\milestone_1\data.mat')
%% Training and Testing 
N = 5;
num_feature = 12;
g = 1/num_feature;
    X_pretrain = cell(11,N); X_pretest = cell(11,N);
    X_train_static = cell(1,N); Y_train_static = cell(1,N);   
    X_train_nstatic = cell(1,N); Y_train_nstatic = cell(1,N); 
n_points = 150;
% separate into static and non-static data
for run_id = 1:N
    for activity = 1:11
        for subj = setdiff(1:5,run_id) % 5-fold cv
            X_pretrain{activity,run_id} = [X_pretrain{activity,run_id}; X_activity{activity,subj}];
        end
    end
    C_train = cellfun('size',X_pretrain,1);

    for activity = [1 2 3 5 7 10 11] % static
        X_train_static{1,run_id} = [X_train_static{1,run_id} ; X_pretrain{activity,run_id}(1:n_points,:)];
%         Y_train{1,run_id} = [Y_train{1,run_id}; activity*ones(C_train(activity,run_id),1)];
        Y_train_static{1,run_id} = [Y_train_static{1,run_id}; activity*ones(n_points,1)];
    end
    
    for activity = [4 6 8 9] % non-static
        X_train_nstatic{1,run_id} = [X_train_nstatic{1,run_id} ; X_pretrain{activity,run_id}(1:n_points,:)];
%         Y_train{1,run_id} = [Y_train{1,run_id}; activity*ones(C_train(activity,run_id),1)];
        Y_train_nstatic{1,run_id} = [Y_train_nstatic{1,run_id}; activity*ones(n_points,1)];
    end
end
X_pretest = X_activity;
C_test = cellfun('size',X_pretest,1);
X_test_static = cell(1,N); Y_test_static = cell(1,N);   
X_test_nstatic = cell(1,N); Y_test_nstatic = cell(1,N); 
for run_id = 1:N
    for activity = [1 2 3 5 7 10 11] % static
        X_test_static{1,run_id} = [X_test_static{1,run_id} ; X_pretest{activity,run_id}];
        Y_test_static{1,run_id} = [Y_test_static{1,run_id}; activity*ones(C_test(activity,run_id),1)];
    end
    
    for activity = [4 6 8 9] % non-static
        X_test_nstatic{1,run_id} = [X_test_nstatic{1,run_id} ; X_pretest{activity,run_id}];
        Y_test_nstatic{1,run_id} = [Y_test_nstatic{1,run_id}; activity*ones(C_test(activity,run_id),1)];
    end
end

% 10-fold cv
acc = zeros(10,1);
for k = 1:10
Xtr_static = []; Xtr_nstatic = []; Xte_static = []; Xte_nstatic = [];
for i = 1:5
    Xtr_static = [Xtr_static;X_train_static{1,i}];
    Xtr_nstatic = [Xtr_nstatic;X_train_nstatic{1,i}];
    Xte_static = [Xte_static;X_test_static{1,i}];
    Xte_nstatic = [Xte_nstatic;X_test_nstatic{1,i}];
end
% static = +1, non-static = -1;
Xtr = [Xtr_static;Xtr_nstatic]; Ytr = [ones(size(Xtr_static,1),1); -ones(size(Xtr_nstatic,1),1)];
Xte = [Xte_static;Xte_nstatic]; Yte = [ones(size(Xte_static,1),1); -ones(size(Xte_nstatic,1),1)];
% GPML toolbox
clc
% Xtr = Xtr(2:end,[1,4,7,10]) - Xtr(1:end-1,[1,4,7,10]);
% Xte = Xte(2:end,[1,4,7,10]) - Xte(1:end-1,[1,4,7,10]);
% Ytr = Ytr(2:end,:); Yte = Yte(2:end,:);

rand_id_tr = randsample(size(Xtr,1),500,true);
Xtr = Xtr(rand_id_tr,:); Ytr = Ytr(rand_id_tr,:); 

rand_id_te = randsample(size(Xte,1),500,true);
Xte = Xte(rand_id_te,:); Yte = Yte(rand_id_te,:);

% centering
Xtr_nl = bsxfun(@rdivide,Xtr,max(Xtr,[],1));
Xte_nl = bsxfun(@rdivide,Xte,max(Xte,[],1));

meanfunc = @meanConst; hyp.mean = 0;
covfunc = @covSEiso; ell = 1.0; sf = 1.0;   hyp.cov =  log([ell sf]);
likfunc = @likLogistic;
hyp = minimize(hyp, @gp, -40, @infEP, meanfunc, covfunc, likfunc, Xte_nl , Ytr);
[ymu, ys2, fmu, fs2, lp] = gp(hyp, @infEP, meanfunc, covfunc, likfunc, Xtr_nl, Ytr, Xte_nl , Yte);
% [nlZ dnlZ ] = gp(hyp, @infEP, meanfunc, covfunc, likfunc, Xtr_nl, Ytr);
prob = exp(lp); Y_final = zeros(size(Yte));
Y_final((prob >= 0.5),:) = 1 ; Y_final((prob < 0.5),:) = -1; 
acc(k,:) = sum(Yte==Y_final)/size(Yte,1);
end
%% Gaussian process MATLAB
% X = X_train{1,1}; Y =Y_train{1,1};
% sigma0 = std(Y);
% sigmaF0 = sigma0;
% phi1 = [mean(std(X));std(Y)/sqrt(2)];
% 
% gpr_sqexp = fitrgp(X,Y,'Basis','constant','Verbose',1,'KernelFunction','squaredexponential',...
% 'KernelParameters',phi1,'Sigma',sigma0,'Standardize',1);
% 
% XX = X_test{1,1}; YY = Y_test{1,1};
% Ypred_sqexp = predict(gpr_sqexp,XX);
% L_sqexp = loss(gpr_sqexp,XX ,YY,'LossFun','mse')
% Y1 = round(Ypred_sqexp);
% acc1 = sum(Y1 == YY)/size(YY,1)
% 
% % phi2 = [std(X)';std(Y)/sqrt(2)];
% gpr_ardsqexp = fitrgp(X,Y,'Basis','constant','Verbose',1,'KernelFunction','ardsquaredexponential',...
% 'Sigma',sigma0,'Standardize',1);
% L_ardsqexp = loss(gpr_ardsqexp,XX ,YY,'LossFun','mse')
% Ypred_ardsqexp = predict(gpr_ardsqexp,XX);
% Y2 = round(Ypred_ardsqexp);
% acc2 = sum(Y2 == YY)/size(YY,1)

