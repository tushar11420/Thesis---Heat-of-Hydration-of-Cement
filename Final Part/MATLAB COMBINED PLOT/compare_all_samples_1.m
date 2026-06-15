function compare_all_samples_1()
%COMPARE_ALL_SAMPLES
%   Generates two separate figures comparing all four cement samples:
%
%   Figure 1 – Heat Generation Rate (1x2 subplots)
%     Left  : Experimental heat generation rate      [all 4 samples]
%     Right : Fitted heat generation rate (Gauss-2)  [all 4 samples]
%
%   Figure 2 – Cumulative Heat Generation (1x2 subplots)
%     Left  : Cumulative heat – experimental         [all 4 samples]
%     Right : Cumulative heat – Gauss-2 fit          [all 4 samples]
%
%   Cement samples

%     Sample 1 : CEM II B-M N         (PCC B-M)
%     Sample 2 : CEM II A-M 42.5 N    (PCC A-M MeghnaCEM)
%     Sample 3 : CEM II A-M 42.5 R    (CEM II A-M 42.5 R)
%     Sample 4 : CEM I 52.5 N         (OPC CEM I)

%
%   Dependencies (must be on the MATLAB path):
%     createFit_Gauss1, createFit_Gauss2, createFit_Gauss3, createFit_Gauss4
%
%   Usage:
%     >> compare_all_samples()

    close all;
    clc;

    %% 1. Retrieve Gauss-2 fit results for each sample 
    %  Each createFit_GaussN opens its own figure; closed immediately so
    %  only the two comparison figures remain visible.

    fprintf('Processing Sample 1  -  CEM II B-M N ...\n');
    [q_g1, q_g_fit1, t_fit1, ~, ~] = createFit_Gauss1();
    close all;

    fprintf('Processing Sample 2  -  CEM II A-M 42.5 N ...\n');
    [q_g2, q_g_fit2, t_fit2, ~, ~] = createFit_Gauss2();
    close all;

    fprintf('Processing Sample 3  -  CEM II A-M 42.5 R ...\n');
    [q_g3, q_g_fit3, t_fit3, ~, ~] = createFit_Gauss3();
    close all;

    fprintf('Processing Sample 4  -  CEM I 52.5 N ...\n');
    [q_g4, q_g_fit4, t_fit4, ~, ~] = createFit_Gauss4();
    close all;

    fprintf('All samples processed. Building comparison figures ...\n\n');

    %% ── 2. Cumulative heat (same Simpson sliding-window as individual scripts)
    %  increment(i) = 5*(f(i) + 4*f(i+1) + f(i+2)) / 6  ,  accumulated

    [qT_exp1, qT_fit1] = cumulative_heat(q_g1, q_g_fit1);
    [qT_exp2, qT_fit2] = cumulative_heat(q_g2, q_g_fit2);
    [qT_exp3, qT_fit3] = cumulative_heat(q_g3, q_g_fit3);
    [qT_exp4, qT_fit4] = cumulative_heat(q_g4, q_g_fit4);

    % Time axes for cumulative plots (end-2, same as individual scripts)
    t_cum1 = t_fit1(1:end-2);
    t_cum2 = t_fit2(1:end-2);
    t_cum3 = t_fit3(1:end-2);
    t_cum4 = t_fit4(1:end-2);

    %% 3. Visual style 
    % Standard MATLAB colour order as RGB triplets (compatible with all versions)
    C = [0.000  0.447  0.741 ;   % blue   - Sample 1
         0.850  0.325  0.098 ;   % orange - Sample 2
         0.466  0.674  0.188 ;   % green  - Sample 3
         0.494  0.184  0.556];   % purple - Sample 4

    LW = 1.0;   % line width
    FS = 15;    % axis label / tick font size

    LABELS = {'CEM II B-M N', ...
              'CEM II A-M 42.5 N', ...
              'CEM II A-M 42.5 R', ...
              'CEM I 52.5 N'};

    %% 4. Figure 1 : Heat Generation Rate
    figure('Name', 'Figure 1 - Heat Generation Rate', ...
           'NumberTitle', 'off', ...
           'Units','normalized', ...
           'OuterPosition',[0 0 1 1]);

 

    % Right subplot : Fitted (Gauss-2)
    ax4 = subplot(2,2,1);
    hold(ax4,'on');
    plot(ax4, t_fit4, q_g4, '-', 'Color',C(4,:), 'LineWidth',LW, 'DisplayName',LABELS{4});
    hold(ax4,'off');
    xlabel(ax4, 'Time elapsed (min)','FontSize',FS);
    ylabel(ax4, 'Heat generation rate (J/min-g)', 'FontSize',FS);
    title(ax4,  'Heat Generation Rate (CEM I 52.5 N)','FontWeight','bold', 'FontSize',FS);
    legend(ax4, 'Location','NorthEast', 'FontSize',FS-1);
    grid(ax4,'on');  box(ax4,'on');

    % Left subplot : Experimental 
    ax3 = subplot(2,2,2);
    hold(ax3,'on');
    plot(ax3, t_fit3, q_g3, '-', 'Color',C(3,:), 'LineWidth',LW, 'DisplayName',LABELS{3});
    hold(ax3,'off');
    xlabel(ax3, 'Time elapsed (min)', 'FontSize',FS);
    ylabel(ax3, 'Heat generation rate (J/min-g)', 'FontSize',FS);
    title(ax3,  'Heat Generation Rate ( CEM II A-M 42.5 R)','FontWeight','bold', 'FontSize',FS);
    legend(ax3, 'Location','NorthEast', 'FontSize',FS-1);
    grid(ax3,'on');  box(ax3,'on');

    % Right subplot : Fitted (Gauss-2)
    ax2 = subplot(2,2,3);
    hold(ax2,'on');
    plot(ax2, t_fit2, q_g2, '-', 'Color',C(2,:), 'LineWidth',LW, 'DisplayName',LABELS{2});
    hold(ax2,'off');
    xlabel(ax2, 'Time elapsed (min)','FontSize',FS);
    ylabel(ax2, 'Heat generation rate  (J/min-g))', 'FontSize',FS);
    title(ax2,  'Heat Generation Rate (CEM II A-M 42.5 N)','FontWeight','bold', 'FontSize',FS);
    legend(ax2, 'Location','NorthEast', 'FontSize',FS-1);
    grid(ax2,'on');  box(ax2,'on');

    % Left subplot : Experimental
    ax1 = subplot(2,2,4);
    hold(ax1,'on');
    plot(ax1, t_fit1, q_g1, '-', 'Color',C(1,:), 'LineWidth',LW, 'DisplayName',LABELS{1});
    hold(ax1,'off');
    xlabel(ax1, 'Time elapsed (min)', 'FontSize',FS);
    ylabel(ax1, 'Heat generation rate  (J/min-g))', 'FontSize',FS);
    title(ax1,  'Heat Generation Rate (CEM II B-M 42.5 N)','FontWeight','bold', 'FontSize',FS);
    legend(ax1, 'Location','NorthEast', 'FontSize',FS-1);
    grid(ax1,'on');  box(ax1,'on');


    sgtitle('Heat Generation Rate  of  All Cement Samples', ...
            'FontSize',FS,'FontWeight','bold');

        %% 5. Figure 1 : Heat Generation Rate - Fitted Data 
    figure('Name', 'Figure 2 - Heat Generation Rate - Fitted Data', ...
           'NumberTitle', 'off', ...
           'Units','normalized', ...
           'OuterPosition',[0 0 1 1]);

    % Left subplot : Experimental 
    ax1 = subplot(2,2,4);
    hold(ax1,'on');
    plot(ax1, t_fit1, q_g_fit1, '-', 'Color',C(1,:), 'LineWidth',LW, 'DisplayName',LABELS{1});
    hold(ax1,'off');
    xlabel(ax1, 'Time elapsed (min)', 'FontSize',FS);
    ylabel(ax1, 'Heat generation rate  (J/min-g))', 'FontSize',FS);
    title(ax1,  'Heat Generation Rate-Fitted (Gauss-2)','FontWeight','bold', 'FontSize',FS);
    legend(ax1, 'Location','NorthEast', 'FontSize',FS-1);
    grid(ax1,'on');  box(ax1,'on');

    % Right subplot : Fitted (Gauss-2)
    ax2 = subplot(2,2,3);
    hold(ax2,'on');
    plot(ax2, t_fit2, q_g_fit2, '-', 'Color',C(2,:), 'LineWidth',LW, 'DisplayName',LABELS{2});
    hold(ax2,'off');
    xlabel(ax2, 'Time elapsed (min)','FontSize',FS);
    ylabel(ax2, 'Heat generation rate  (J/min-g))', 'FontSize',FS);
    title(ax2,  'Heat Generation Rate-Fitted (Gauss-2)','FontWeight','bold', 'FontSize',FS);
    legend(ax2, 'Location','NorthEast', 'FontSize',FS-1);
    grid(ax2,'on');  box(ax2,'on');

    % Left subplot : Experimental 
    ax3 = subplot(2,2,2);
    hold(ax3,'on');
    plot(ax3, t_fit3, q_g_fit3, '-', 'Color',C(3,:), 'LineWidth',LW, 'DisplayName',LABELS{3});
    hold(ax3,'off');
    xlabel(ax3, 'Time elapsed (min)', 'FontSize',FS);
    ylabel(ax3, 'Heat generation rate (J/min-g)', 'FontSize',FS);
    title(ax3,  'Heat Generation Rate-Fitted (Gauss-2)','FontWeight','bold', 'FontSize',FS);
    legend(ax3, 'Location','NorthEast', 'FontSize',FS-1);
    grid(ax3,'on');  box(ax3,'on');

    % Right subplot : Fitted (Gauss-2)
    ax4 = subplot(2,2,1);
    hold(ax4,'on');
    plot(ax4, t_fit4, q_g_fit4, '-', 'Color',C(4,:), 'LineWidth',LW, 'DisplayName',LABELS{4});
    hold(ax4,'off');
    xlabel(ax4, 'Time elapsed (min)','FontSize',FS);
    ylabel(ax4, 'Heat generation rate (J/min-g)', 'FontSize',FS);
    title(ax4,  'Heat Generation Rate-Fitted (Gauss-2)','FontWeight','bold', 'FontSize',FS);
    legend(ax4, 'Location','NorthEast', 'FontSize',FS-1);
    grid(ax4,'on');  box(ax4,'on');


    sgtitle('Heat Generation Rate fo fitted Data ( Gauss-2) of  All Cement Samples', ...
            'FontSize',FS,'FontWeight','bold');

    %% 6. Figure 3 : Cumulative Heat Generation 
    figure('Name','Figure 3- Cumulative Heat Generation', ...
           'NumberTitle', 'off', ...
           'Units','normalized', ...
           'OuterPosition',[0 0 1 1]);

    %  Left subplot : Experimental
    ax1 = subplot(1,2,1);
    hold(ax1,'on');
    plot(ax1, t_cum4, qT_exp4, '-', 'Color',C(4,:), 'LineWidth',LW, 'DisplayName',LABELS{4});
    plot(ax1, t_cum3, qT_exp3, '-', 'Color',C(3,:), 'LineWidth',LW, 'DisplayName',LABELS{3});
    plot(ax1, t_cum2, qT_exp2, '-', 'Color',C(2,:), 'LineWidth',LW, 'DisplayName',LABELS{2});
    plot(ax1, t_cum1, qT_exp1, '-', 'Color',C(1,:), 'LineWidth',LW, 'DisplayName',LABELS{1});
    hold(ax1,'off');
    xlabel(ax1, 'Time elapsed (min)', 'FontSize',FS);
    ylabel(ax1, 'Cumulative heat generation (J/g)', 'FontSize',FS);
    title(ax1, 'Cumulative Heat Generation  -  Experimental', 'FontWeight','bold','FontSize',FS);
    legend(ax1, 'Location','NorthWest', 'FontSize',FS-1);
    grid(ax1,'on');  box(ax1,'on');

    % Right subplot : Fitted (Gauss-2) 
    ax2 = subplot(1,2,2);
    hold(ax2,'on');
    plot(ax2, t_cum4, qT_fit4, '-', 'Color',C(4,:), 'LineWidth',LW, 'DisplayName',LABELS{4});
    plot(ax2, t_cum3, qT_fit3, '-', 'Color',C(3,:), 'LineWidth',LW, 'DisplayName',LABELS{3});
    plot(ax2, t_cum2, qT_fit2, '-', 'Color',C(2,:), 'LineWidth',LW, 'DisplayName',LABELS{2});
    plot(ax2, t_cum1, qT_fit1, '-', 'Color',C(1,:), 'LineWidth',LW, 'DisplayName',LABELS{1});
    
    
    
    hold(ax2,'off');
    xlabel(ax2, 'Time elapsed (min)', 'FontSize',FS);
    ylabel(ax2, 'Cumulative heat generation (J/g))', 'FontSize',FS);
    title(ax2,  'Cumulative Heat Generation  -  Gauss-2 Fit',  'FontWeight','bold','FontSize',FS);
    legend(ax2, 'Location','NorthWest', 'FontSize',FS-1);
    grid(ax2,'on');  box(ax2,'on');

    sgtitle('Cumulative Heat Generation  -  Comparison of All Cement Samples', ...
            'FontSize',15,'FontWeight','bold');

    fprintf('Done. Two comparison figures ready.\n');
end


%%
%  LOCAL FUNCTION : cumulative_heat
%  Applies the same Simpson sliding-window integration used in every
%  individual createFit script:
%      increment(i) = 5*(q(i) + 4*q(i+1) + q(i+2)) / 6
%      total(i)     = running sum of increment(1:i)
%
%  Inputs
%    q_g      - experimental heat generation rate vector  (length N)
%    q_g_fit  - fitted    heat generation rate vector     (length N)
%  Outputs
%    q_total_exp - cumulative heat, experimental data     (length N-2)
%    q_total_fit - cumulative heat, fitted data           (length N-2)
%%
function [q_total_exp, q_total_fit] = cumulative_heat(q_g, q_g_fit)

    n = length(q_g) - 2;

    % Experimental
    inc_exp = zeros(1, n);
    for i = 1:n
        inc_exp(i) = 5*(q_g(i) + 4*q_g(i+1) + q_g(i+2)) / 6;
    end
    q_total_exp = cumsum(inc_exp);

    % Fitted
    inc_fit = zeros(1, n);
    for i = 1:n
        inc_fit(i) = 5*(q_g_fit(i) + 4*q_g_fit(i+1) + q_g_fit(i+2)) / 6;
    end
    q_total_fit = cumsum(inc_fit);

end
