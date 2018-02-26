% Created: 01/03/2018
% Data description: https://archive.ics.uci.edu/ml/machine-learning-databases/00196/dataSetDescription.names
% RunLength function is required to run this file, which is available at:
% https://www.mathworks.com/matlabcentral/fileexchange/41813-runlength
%% Data processing
clc;clear
[num,txt,raw] = xlsread('ConfLongDemo_JSI.xlsx');
Subject = zeros(size(raw,1),6);
for i = 1:size(raw,1)
    if strcmp(txt{i,2},'010-000-024-033') % ANKLE_LEFT
        raw{i,2} = 1;
    elseif strcmp(txt{i,2},'010-000-030-096') % ANKLE_RIGHT
        raw{i,2} = 2;
    elseif strcmp(txt{i,2},'020-000-033-111') % CHEST
        raw{i,2} = 3;
    elseif strcmp(txt{i,2},'020-000-032-221') % BELT
        raw{i,2} = 4;
    end
    
    if strcmp(txt{i,8},'walking')
        raw{i,8} = 1;
    elseif strcmp(txt{i,8},'falling')
        raw{i,8} = 2;
    elseif strcmp(txt{i,8},'lying down')
        raw{i,8} = 3;
    elseif strcmp(txt{i,8},'lying')
        raw{i,8} = 4;
    elseif strcmp(txt{i,8},'sitting down')
        raw{i,8} = 5;
    elseif strcmp(txt{i,8},'sitting')
        raw{i,8} = 6;
    elseif strcmp(txt{i,8},'standing up from lying')
        raw{i,8} = 7;
    elseif strcmp(txt{i,8},'on all fours')
        raw{i,8} = 8;
    elseif strcmp(txt{i,8},'sitting on the ground')
        raw{i,8} = 9;
    elseif strcmp(txt{i,8},'standing up from sitting')
        raw{i,8} = 10;
    elseif strcmp(txt{i,8},'standing up from sitting on the ground')
        raw{i,8} = 11;
    end
    
    if strcmp(txt{i,1},'A01') || strcmp(txt{i,1},'A02') || strcmp(txt{i,1},'A03')|| strcmp(txt{i,1},'A04')||strcmp(txt{i,1},'A05')
        raw{i,1} = 1;
    elseif strcmp(txt{i,1},'B01') || strcmp(txt{i,1},'B02') || strcmp(txt{i,1},'B03')|| strcmp(txt{i,1},'B04')||strcmp(txt{i,1},'B05')
        raw{i,1} = 2;
    elseif strcmp(txt{i,1},'C01') || strcmp(txt{i,1},'C02') || strcmp(txt{i,1},'C03')|| strcmp(txt{i,1},'C04')||strcmp(txt{i,1},'C05')
        raw{i,1} = 3;
    elseif strcmp(txt{i,1},'D01') || strcmp(txt{i,1},'D02') || strcmp(txt{i,1},'D03')|| strcmp(txt{i,1},'D04')||strcmp(txt{i,1},'D05')
        raw{i,1} = 4;
    elseif strcmp(txt{i,1},'E01') || strcmp(txt{i,1},'E02') || strcmp(txt{i,1},'E03')|| strcmp(txt{i,1},'E04')||strcmp(txt{i,1},'E05')
        raw{i,1} = 5;
    end 
    Subject(i,1) = raw{i,1};
    Subject(i,2) = raw{i,2};
    Subject(i,3) = raw{i,5};
    Subject(i,4) = raw{i,6};
    Subject(i,5) = raw{i,7};
    Subject(i,6) = raw{i,8};
    
end
%%
clearvars -except Subject
X_activity = cell(11,5);
activity_choice = [1 4 6 7 9];
for sub = 1:5
index = find(Subject(:,1) == sub); % For subject 1
X = Subject(index,1:end-1); Y = Subject(index,end);
ANKLE_LEFT = find(X(:,2)==1);  ANKLE_RIGHT = find(X(:,2)==2);
CHEST = find(X(:,2)==3); BELT = find(X(:,2)==4);
X_ANKLE_LEFT = Subject(ANKLE_LEFT,3:6);
X_ANKLE_RIGHT = Subject(ANKLE_RIGHT,3:6);
X_CHEST = Subject(CHEST,3:6);
X_BELT = Subject(BELT,3:6);

% find out the sequence of activity
[b_al, n_al, idx_al] = RunLength(X_ANKLE_LEFT(:,4));
[b_ar, n_ar, idx_ar] = RunLength(X_ANKLE_RIGHT(:,4));
[b_ch, n_ch, idx_ch] = RunLength(X_CHEST(:,4));
[b_be, n_be, idx_be] = RunLength(X_BELT(:,4));

X_l = []; X_r = []; X_c = []; X_b = [];
for activity = activity_choice
    idx_l = find(b_al == activity);
    for j = 1:length(idx_l)
        X_temp = X_ANKLE_LEFT(idx_al(idx_l(j)):idx_al(idx_l(j)) + n_al(idx_l(j)) - 1,:);
        X_l = [X_l;X_temp];
    end
    X_temp = [];
    idx_r = find(b_ar == activity);
    for j = 1:length(idx_r)
        X_temp = X_ANKLE_RIGHT(idx_ar(idx_r(j)):idx_ar(idx_r(j)) + n_ar(idx_r(j)) - 1,:);
        X_r = [X_r;X_temp];
    end
    
    X_temp = [];
    idx_c = find(b_ch == activity);
    for j = 1:length(idx_c)
        X_temp = X_CHEST(idx_ch(idx_c(j)):idx_ch(idx_c(j)) + n_ch(idx_c(j)) - 1,:);
        X_c = [X_c;X_temp];
    end
    
    X_temp = [];
    idx_b = find(b_be == activity);
    for j = 1:length(idx_b)
        X_temp = X_BELT(idx_be(idx_b(j)):idx_be(idx_b(j)) + n_be(idx_b(j)) - 1,:);
        X_b = [X_b;X_temp];
    end
    min_dim = min([length(X_l),length(X_r),length(X_c),length(X_b)]);
    X_activity{activity,sub} = [X_l(1:min_dim,1:3),X_r(1:min_dim,1:3),X_c(1:min_dim,1:3),X_b(1:min_dim,1:3)];
    X_l = []; X_r = []; X_c = []; X_b = [];
end

end
% X_activity is the 11 type of actions
% Try: get velocity