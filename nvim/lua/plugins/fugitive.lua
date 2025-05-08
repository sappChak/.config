return {
	"tpope/vim-fugitive",
	config = function()
		vim.cmd([[
      nnoremap <silent> <leader>gs :Git<CR>
      nnoremap <silent> <leader>gd :Gdiff<CR>
      nnoremap <silent> <leader>gc :Gcommit<CR>
      nnoremap <silent> <leader>gp :Git push<CR>
      nnoremap <silent> <leader>gb :Git blame<CR>
      nnoremap <silent> <leader>gl :Glog<CR>
      nnoremap <silent> <leader>gj :diffget //2<CR>
      nnoremap <silent> <leader>gf :diffget //3<CR>
      nnoremap <silent> <leader>gr :Gread<CR>
      nnoremap <silent> <leader>gw :Gwrite<CR>
      nnoremap <silent> <leader>gS :Gstatus<CR>
      nnoremap <silent> <leader>gC :Gcommit --amend<CR>
      nnoremap <silent> <leader>gR :Gremove<CR>
      nnoremap <silent> <leader>gA :Git add .<CR>
      nnoremap <silent> <leader>gD :Gdiffsplit<CR>
      nnoremap <silent> <leader>gB :Gblame<CR>
      nnoremap <silent> <leader>gP :Git push<CR>
      nnoremap <silent> <leader>gG :Git pull<CR>
      nnoremap <silent> <leader>gT :Gcommit --amend --no-edit<CR>
      nnoremap <silent> <leader>gQ :Gclog<CR>
      nnoremap <silent> <leader>gF :Gfetch<CR>
      nnoremap <silent> <leader>gI :Gpull<CR>
      nnoremap <silent> <leader>gO :Gpush<CR>
      nnoremap <silent> <leader>gE :Gedit<CR>
      nnoremap <silent> <leader>gM :Gmove<CR>
      nnoremap <silent> <leader>gS :Gstatus<CR>
      nnoremap <silent> <leader>gX :Gx<CR>]])
	end,
}
