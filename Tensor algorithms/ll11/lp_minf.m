function [U,output] = lp_minf(T,U0,varargin)
%LP_MINF LP decomposition by nonlinear unconstrained optimization
%   [U,output] = lp_minf(T,U0) computes R terms U{r} corresponding to a lp
%   decomposition in BTD format of the Nth-order tensor T by minimizing
%   0.5*frob(T-lvecgen(U))^2. Each term U{r} is a cell array of N1 factor
%   matrices U{r}{n1} with L(r) columns for n1 = 1, ..., N1, N2 factor
%   matrices U{r}{n2} with P(r) columns for n2 = 1, ..., N2, followed by a
%   Nth-order core tensor U{r}{N+1} with a specific structure. We have that
%   N1+N2 = N. The algorithm is initialized with the terms matrices U0{r}.
%   The structure output returns additional information:
%
%      output.Name  - The name of the selected algorithm.
%      output.<...> - The output of the selected algorithm.
%
%   U = lp_minf(T,U0,N,L,P) computes the factor matrices U{n} corresponding
%   to the lp decomposition in the CPD format of the Nth-order tensor T.
%   The U{n1}, n1 = 1, ..., N1 have sum(L) columns and the U{n2}, n2 = 
%   N1+1, ... N1+N2, have sum(P) columns.
%
%   lp_nls(T,U0,options), lp_nls(T,U0,N,L,P,options),
%   lp_nls(T,U0,'key',value), and lp_nls(T,U0,N,L,P,'key',value) may be
%   used to set the following options:
%
%      options.Algorithm =     - The desired optimization method.
%      [{@minf_lbgfsdl}|...
%       @minf_lbfgs,@minf_ncg]
%      options.<...>           - Parameters passed to the selected method,
%                                e.g., options.TolFun, options.TolX. See also
%                                help [options.Algorithm].
%      options.OutputFormat    - Either 'btd' or 'cpd'. If not given, the
%                                same format as the input is used. 
%
%   See also lp_nls.

%   Authors: Martijn Bouss� (Martijn.Bousse@esat.kuleuven.be)
%            Nico Vervliet (Nico.Vervliet@esat.kuleuven.be)
%            Lieven De Lathauwer (Lieven.DeLathauwer@kuleuven-kulak.be)

    if ~isempty(varargin) && all(cellfun(@isnumeric,varargin(1:3)))
        [U, output] = lp_core(T,U0,varargin{1},varargin{2},varargin{3}, ...
                      'Algorithm', @minf_lbfgsdl,'OptimizationType', ...
                      'minf', varargin{4:end});
    else 
        [U, output] = lp_core(T,U0,'Algorithm',@minf_lbfgsdl,'OptimizationType', ...
                               'minf', varargin{:});
    end
end

