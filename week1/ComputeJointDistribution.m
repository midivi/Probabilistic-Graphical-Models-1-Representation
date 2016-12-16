%ComputeJointDistribution Computes the joint distribution defined by a set
% of given factors
%
%   Joint = ComputeJointDistribution(F) computes the joint distribution
%   defined by a set of given factors
%
%   Joint is a factor that encapsulates the joint distribution given by F
%   F is a vector of factors (struct array) containing the factors 
%     defining the distribution
%

function Joint = ComputeJointDistribution(F)

  % Check for empty factor list
  if (numel(F) == 0)
      warning('Error: empty factor list');
      Joint = struct('var', [], 'card', [], 'val', []);      
      return;
  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE:
% Compute the joint distribution defined by F
% You may assume that you are given legal CPDs so no input checking is required.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
Joint = struct('var', [], 'card', [], 'val', []); % Returns empty factor. Change this.

for i = 1:length(F)
	varNames = F(i).var;
	varValues = F(i).val;
	varCards = F(i).card;

	for j = 1:length(varNames)
		varname = varNames(j);
		card = varCards(j);
		if any(Joint.var == varname) == 0
			Joint.var = [Joint.var varname];
			Joint.card = [Joint.card card];
		end
	end
end
[_, outputVarMap] = ismember(Joint.var, sort(Joint.var));
Joint.var = Joint.var(outputVarMap);
Joint.card = Joint.card(outputVarMap);
Joint.val = ones(1, prod(Joint.card));
jointAssignment = IndexToAssignment(1:length(Joint.val), Joint.card);

for i = 1:length(F)
	varNames = F(i).var;
	varValues = F(i).val;
	varCards = F(i).card;
	varAssignments = IndexToAssignment(1:length(varValues), varCards);
	[_, map] = ismember(varNames, Joint.var);
	for j = 1:length(varValues)
		varAssignments_= varAssignments(j,:);
		for output_idx = 1:length(Joint.val)
			jointAssignment_ = jointAssignment(output_idx, map);
			if jointAssignment(output_idx, map)	== varAssignments(j,:)
				Joint.val(output_idx) = Joint.val(output_idx) * varValues(j);
			end
		end
	end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

