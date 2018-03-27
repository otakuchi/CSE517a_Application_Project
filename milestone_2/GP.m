clc;clear
load ('C:\Users\Yao-Chi\OneDrive - Washington University in St. Louis\2018 Spring\Machine Learning\Application Project\CSE517a_Application_Project.git\trunk\milestone_1\data.mat')
%% Training and Testing 
N = 5;
num_feature = 12;
g = 1/num_feature;
    X_pretrain = cell(11,N); X_pretest = cell(11,N);
    X_train = cell(1,N); Y_train = cell(1,N);   
    
for run_id = 1:N
    for activity = 1:11
        for subj = setdiff(1:5,run_id) % 5-fold cv
            X_pretrain{activity,run_id} = [X_pretrain{activity,run_id}; X_activity{activity,subj}];
        end
    end
    C_train = cellfun('size',X_pretrain,1);

    for activity = 1:11
        X_train{1,run_id} = [X_train{1,run_id} ; X_pretrain{activity,run_id}(1:150,:)];
%         Y_train{1,run_id} = [Y_train{1,run_id}; activity*ones(C_train(activity,run_id),1)];
        Y_train{1,run_id} = [Y_train{1,run_id}; activity*ones(150,1)];
    end
end
X_pretest = X_activity;
C_test = cellfun('size',X_pretest,1);
    X_test = cell(1,N); Y_test = cell(1,N);   
for run_id = 1:N
    for activity = 1:11
        X_test{1,run_id} = [X_test{1,run_id} ; X_pretest{activity,run_id}];
        Y_test{1,run_id} = [Y_test{1,run_id}; activity*ones(C_test(activity,run_id),1)];
    end
end
%% Gaussian process MATLAB

X = X_train{1,1}; Y =Y_train{1,1};
sigma0 = std(Y);
sigmaF0 = sigma0;
phi1 = [mean(std(X));std(Y)/sqrt(2)];

gpr_sqexp = fitrgp(X,Y,'Basis','constant','Verbose',1,'KernelFunction','squaredexponential',...
'KernelParameters',phi1,'Sigma',sigma0,'Standardize',1);

XX = X_test{1,1}; YY = Y_test{1,1};
Ypred_sqexp = predict(gpr_sqexp,XX);
L_sqexp = loss(gpr_sqexp,XX ,YY,'LossFun','mse')

% phi2 = [std(X)';std(Y)/sqrt(2)];
gpr_ardsqexp = fitrgp(X,Y,'Basis','constant','Verbose',1,'KernelFunction','ardsquaredexponential',...
'Sigma',sigma0,'Standardize',1);
L_ardsqexp = loss(gpr_ardsqexp,XX ,YY,'LossFun','mse')
Ypred_ardsqexp = predict(gpr_ardsqexp,XX);

%% GPML toolbox
  
  Xtr = X_train{1,1}; Ytr = Y_train{1,1};
  Xte = X_test{1,1}; Yte = Y_test{1,1};

hycov = [std(Xtr)';std(Ytr)/sqrt(2)]';
hymean = [mean(Xtr)';mean(Ytr)]';

meanfunc = @meanConst; hyp.mean = 0;                    % empty: don't use a mean function
covfunc = @covSEard;   hyp.cov = hycov;              % Squared Exponental covariance function
likfunc = @likErf;             % Gaussian likelihood

  n = 11*150;
  hyp = minimize(hyp, @gp, -40, @infEP, meanfunc, covfunc, likfunc, Xtr, Ytr);
  
  nu = fix(n/2); iu = randperm(n); iu = iu(1:nu); u = Xtr(iu,:); yu = Ytr(iu,:);
  covfuncF = {@apxSparse, {covfunc}, u};
  inf = @(varargin) infGaussLik(varargin{:}, struct('s', 0.0));
  hyp = minimize(hyp, @gp, -100, inf, meanfunc, covfuncF, likfunc, u, yu);
  [mF s2F] = gp(hyp, inf, meanfunc, covfuncF, likfunc, u, yu, Xte);
  
  

