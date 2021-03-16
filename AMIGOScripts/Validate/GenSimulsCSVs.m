

%% Iteration 0 
simul_res0 = load("Results\SimulationResults_16-Mar-2021_PLacIter0ValidationSet.mat");

it0 = zeros(288,4);
it0(:,1) = simul_res0.simul_res.resultsPL.sim.tsim{1};
it0(:,2) = simul_res0.simul_res.resultsPL.sim.states{1}(:,4);
it0(:,3) = simul_res0.simul_res.resultsPL.sim.states{2}(:,4);
it0(:,4) = simul_res0.simul_res.resultsPL.sim.states{3}(:,4);

header2 = strings(1,4);
header2(1) = 'Time(min)';
header2(2) = 'Pulses';
header2(3) = 'Random';
header2(4) = 'Step';

% Write CSV file
cHeader2 = num2cell(header2); %dummy header
for i=1:length(cHeader2)
cHeader2{i} = char(cHeader2{i});
end
textHeader = strjoin(cHeader2, ',');
%write header to file
fid = fopen(['Validate\Iter0.csv'],'w'); 
fprintf(fid,'%s\n',textHeader);
fclose(fid);
%write data to end of file
dlmwrite(['Validate\Iter0.csv'],it0,'-append');



%% Iteration 1, Model 1 
simul_res11 = load("Results\SimulationResults_16-Mar-2021_PLacIter1Model1ValidationSet.mat");

it1 = zeros(288,4);
it1(:,1) = simul_res11.simul_res.resultsPL.sim.tsim{1};
it1(:,2) = simul_res11.simul_res.resultsPL.sim.states{1}(:,4);
it1(:,3) = simul_res11.simul_res.resultsPL.sim.states{2}(:,4);
it1(:,4) = simul_res11.simul_res.resultsPL.sim.states{3}(:,4);

header2 = strings(1,4);
header2(1) = 'Time(min)';
header2(2) = 'Pulses';
header2(3) = 'Random';
header2(4) = 'Step';

% Write CSV file
cHeader2 = num2cell(header2); %dummy header
for i=1:length(cHeader2)
cHeader2{i} = char(cHeader2{i});
end
textHeader = strjoin(cHeader2, ',');
%write header to file
fid = fopen(['Validate\Iter1Model1.csv'],'w'); 
fprintf(fid,'%s\n',textHeader);
fclose(fid);
%write data to end of file
dlmwrite(['Validate\Iter1Model1.csv'],it1,'-append');



%% Iteration 1, Model 2 
simul_res12 = load("Results\SimulationResults_16-Mar-2021_PLacIter1Model2ValidationSet.mat");

it1 = zeros(288,4);
it1(:,1) = simul_res12.simul_res.resultsPL.sim.tsim{1};
it1(:,2) = simul_res12.simul_res.resultsPL.sim.states{1}(:,4);
it1(:,3) = simul_res12.simul_res.resultsPL.sim.states{2}(:,4);
it1(:,4) = simul_res12.simul_res.resultsPL.sim.states{3}(:,4);

header2 = strings(1,4);
header2(1) = 'Time(min)';
header2(2) = 'Pulses';
header2(3) = 'Random';
header2(4) = 'Step';

% Write CSV file
cHeader2 = num2cell(header2); %dummy header
for i=1:length(cHeader2)
cHeader2{i} = char(cHeader2{i});
end
textHeader = strjoin(cHeader2, ',');
%write header to file
fid = fopen(['Validate\Iter1Model2.csv'],'w'); 
fprintf(fid,'%s\n',textHeader);
fclose(fid);
%write data to end of file
dlmwrite(['Validate\Iter1Model2.csv'],it1,'-append');


%% Iteration 2, Model 1 
simul_res21 = load("Results\SimulationResults_16-Mar-2021_PLacIter2Model1ValidationSet.mat");

it2 = zeros(288,4);
it2(:,1) = simul_res21.simul_res.resultsPL.sim.tsim{1};
it2(:,2) = simul_res21.simul_res.resultsPL.sim.states{1}(:,4);
it2(:,3) = simul_res21.simul_res.resultsPL.sim.states{2}(:,4);
it2(:,4) = simul_res21.simul_res.resultsPL.sim.states{3}(:,4);

header2 = strings(1,4);
header2(1) = 'Time(min)';
header2(2) = 'Pulses';
header2(3) = 'Random';
header2(4) = 'Step';

% Write CSV file
cHeader2 = num2cell(header2); %dummy header
for i=1:length(cHeader2)
cHeader2{i} = char(cHeader2{i});
end
textHeader = strjoin(cHeader2, ',');
%write header to file
fid = fopen(['Validate\Iter2Model1.csv'],'w'); 
fprintf(fid,'%s\n',textHeader);
fclose(fid);
%write data to end of file
dlmwrite(['Validate\Iter2Model1.csv'],it2,'-append');




%% Iteration 2, Model 1 
simul_res22 = load("Results\SimulationResults_16-Mar-2021_PLacIter2Model2ValidationSet.mat");

it2 = zeros(288,4);
it2(:,1) = simul_res22.simul_res.resultsPL.sim.tsim{1};
it2(:,2) = simul_res22.simul_res.resultsPL.sim.states{1}(:,4);
it2(:,3) = simul_res22.simul_res.resultsPL.sim.states{2}(:,4);
it2(:,4) = simul_res22.simul_res.resultsPL.sim.states{3}(:,4);

header2 = strings(1,4);
header2(1) = 'Time(min)';
header2(2) = 'Pulses';
header2(3) = 'Random';
header2(4) = 'Step';

% Write CSV file
cHeader2 = num2cell(header2); %dummy header
for i=1:length(cHeader2)
cHeader2{i} = char(cHeader2{i});
end
textHeader = strjoin(cHeader2, ',');
%write header to file
fid = fopen(['Validate\Iter2Model2.csv'],'w'); 
fprintf(fid,'%s\n',textHeader);
fclose(fid);
%write data to end of file
dlmwrite(['Validate\Iter2Model2.csv'],it2,'-append');



































