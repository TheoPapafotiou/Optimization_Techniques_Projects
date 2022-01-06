function [sorted_mat] = sort_fit(mat, column)

    [~,idx] = sort(mat(:,column)); % sort just the given column
    sorted_mat = mat(idx,:);       % sort the whole matrix using the sort indices
end

