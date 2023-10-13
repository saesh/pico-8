pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

render = true

maxiter = 10
mr = 4
mx = 0
my = 0

p = { 1, 13, 12, 5, 4, 9, 10, 7 }
setcolor = 0

function _init()
	cls(0)
end

function _update()
	if not render then
		return
	end

	if not cor then
		cor = cocreate(update_pixels)
	end

	if cor and costatus(cor) != 'dead' then
		coresume(cor)
	else
		cor = nil
	end
end

function update_pixels()
	for x = 0, 127 do
		for y = 0, 127 do
			pset(x, y, to_color(is_inset(map(x, y))))
		end
		yield()
	end
	render = false
end

function map(x, y)
	r = x * mr / 128 - mr / 2 + mx
	i = (y * mr / 128 - mr / 2) * -1 + my

	return r, i
end

function to_color(inset, it)
	if (inset) return setcolor
	return p[it % #p]
end

function is_inset(r, i)
	local cr = r
	local ci = i
	local zr = cr
	local zi = ci

	for iter = 0, maxiter do
		local zr_sq = zr * zr
		local zi_sq = zi * zi
		if zr_sq + zi_sq > 4 then
			return false, iter
		end

		local newzr = zr_sq - zi_sq + cr
		local newzi = zr * zi * 2 + ci
		zr = newzr
		zi = newzi
	end

	return true, maxiter
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
