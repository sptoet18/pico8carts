pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- pico8util
-- click18

function _init()

end

function _update()
	
end

function _draw()
	
end
-->8
-- shapes

function interpolate(i0, d0, i1, d1)
	if (i0 == i1) return {d0}
	
	values = {}
	a = (d1 - d0) / (i1 - i0)
	d = d0
	
	for i = i0, i1 do
		add(values, flr(d))
		d = d + a
	end
	
	return values
end

function line2(x1, y1, x2, y2, col)
	if (abs(x2 - x1) > abs(y2 - y1)) then
		if (x1 > x2) then
			x1, x2 = swap(x1, x2)
			y1, y2 = swap(y1, y2)
		end

		ys = interpolate(x1, y1, x2, y2)
		for x = x1, x2 do
			pset(x, ys[x - x1 + 1], col)
		end
	else
		if (y1 > y2) then
			x1, x2 = swap(x1, x2)
			y1, y2 = swap(y1, y2)
		end

		xs = interpolate(y1, x1, y2, x2)
		for y = y1, y2 do
			pset(xs[y - y1 + 1], y, col)
		end
	end
end

function triangle(x1, y1, x2, y2, x3, y3, col)
	line2(x1, y1, x2, y2, col)
	line2(x2, y2, x3, y3, col)
	line2(x3, y3, x1, y1, col)
end

function triangle_fill(x1, y1, x2, y2, x3, y3, col)
	if (y1 > y2) then
		x1, x2 = swap(x1, x2)
		y1, y2 = swap(y1, y2)
	end
	if (y1 > y3) then
		x1, x3 = swap(x1, x3)
		y1, y3 = swap(y1, y3)
	end
	if (y2 > y3) then
		x2, x3 = swap(x2, x3)
		y2, y3 = swap(y2, y3)
	end

	printh("y1: "..y1)
	printh("y2: "..y2)
	printh("y3: "..y3)

	x12 = interpolate(y1, x1, y2, x2)
	x23 = interpolate(y2, x2, y3, x3)
	x13 = interpolate(y1, x1, y3, x3)

	deli(x12, #x12)

	x123 = concat(x12, x23)

	m = round(#x123 / 2)
	if (x13[m] < x123[m]) then
		x_left = x13
		x_right = x123
	else
		x_left = x123
		x_right = x13
	end

	printh("x left: "..x_left[m])
	printh("x right: "..x_right[m])

	for y = y1, y3 do
		for x = x_left[y - y1 + 1], x_right[y - y1 + 1] do
			-- printh("x: " .. x .. " y: " .. y)
			pset(x, y, col)
		end
	end
end

function triangle_center(x1, y1, x2, y2, x3, y3)
	x = round((x1 + x2 + x3) / 3)
	y = round((y1 + y2 + y3) / 3)

	return x, y
end

-->8
-- utilities

-- swaps the values
-- @param a first variable
-- @param b second variable
-- @return swapped variables
-- @notes Example: a, b = swap(a, b) will swap the values of a and b
function swap(a, b)
	return b, a
end

-- cncatenates Arrays
-- @param array1 first array
-- @param array2 second array
-- @result result concatenated array
function concat(array1, array2)
	result = {}
	for value in all(array1) do add(result, value) end
	for value in all(array2) do add(result, value) end

	return result
end

function round(value)
	return flr(value + 0.5)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
