function temp = exponential_filter(var, time, tau0, tau_fact)
    % Check if tau_fact was provided
    if nargin < 3
        tau_fact = 0;
    end

    % Initialize variables
    n = length(var);
    temp = zeros(size(var));
    dt = 1; % Since time difference is always 1 second

    % Adjust tau for each point
    tau_dep = tau0 + tau_fact; 
    ef = exp(-dt ./ tau_dep);

    % Handle cases where ef is 1 or very close to 1
    ef(ef >= 0.9999) = 0.9999;

    temp(1) = var(1); % Initial condition, first point same as in original data

    for i = 2:n
        if isnan(var(i))
            temp(i) = NaN; % Retain NaNs in the output
        else
            if isnan(temp(i-1)) % If the previous value is NaN, use the current input value
                temp(i) = var(i);
            else % Regular calculation if no NaNs involved
                temp(i) = var(i) * (1 - ef) + temp(i-1) * ef;
            end
        end
    end
end