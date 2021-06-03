# Global Trangle method
def triangle(a,b,c)
  if a==b && b==c
    :equilateral
  elsif a==b || b==c || c==a
    :isosceles
  else
    :scalene
  end
end