require("vector")

function love.load()
    vec = Vector:create(-5, 10)
    print(vec)

    vec1 = Vector:create(2,2)

    print(vec + vec1)
    print(vec - vec1)
    print(vec * 2)
    print(vec/2)

    vec3 = Vector:create(3,1)
    print(vec3:mag())
    print(vec3:norm())
end