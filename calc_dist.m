function[dist] = calc_dist(bot_ctr, res_ctr, sfact)  %calculate distance between bot and resource at any given time
dist = pdist([bot_ctr(1)*sfact(1), bot_ctr(2)*sfact(2); res_ctr(1)*sfact(1), res_ctr(2)*sfact(2)]);
end