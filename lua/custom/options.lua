local function is_normal_buffer()
    -- Check if the buffer is a normal, modifiable file buffer
    return vim.bo.buftype == '' and vim.bo.modifiable
end

vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        if is_normal_buffer() then
            vim.b.updaterestore = vim.opt.updatetime:get()
            vim.opt.updatetime = 10000
        end
    end
})

vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        if is_normal_buffer() then
            if vim.b.updaterestore then
                vim.opt.updatetime = vim.b.updaterestore
                vim.b.updaterestore = nil
            end
        end
    end
})
