n = 30
m = 20
p = 5

info("Testing ", MODPF.dotvectors!)
for T in FloatingPointTypes
    Set_X = [rand(T, p) for i = 1:n]
    Set_Y = [rand(T,p)  for i = 1:m]

    X = transpose(hcat(Set_X...))
    Y = transpose(hcat(Set_Y...))
    
    @test_approx_eq MODPF.dotvectors(RowMajor(), X) sum((X.*X),2)
    @test_approx_eq MODPF.dotvectors(ColumnMajor(), X) sum((X.*X),1)

    @test_approx_eq MODPF.dotvectors!(RowMajor(), Array(T,n), X) sum((X.*X),2)
    @test_approx_eq MODPF.dotvectors!(ColumnMajor(), Array(T,p), X) sum((X.*X),1)

    @test_throws DimensionMismatch MODPF.dotvectors!(RowMajor(), Array(T,2), Array(T,3,2))
    @test_throws DimensionMismatch MODPF.dotvectors!(RowMajor(), Array(T,4), Array(T,3,4))
    @test_throws DimensionMismatch MODPF.dotvectors!(ColumnMajor(), Array(T,2), Array(T,2,3))
end

info("Testing ", MODPF.gramian!)
for T in FloatingPointTypes
    Set_X = [rand(T, p) for i = 1:n]
    Set_Y = [rand(T,p)  for i = 1:m]

    X = transpose(hcat(Set_X...))
    Y = transpose(hcat(Set_Y...))

    P = [dot(x,y) for x in Set_X, y in Set_X]

    @test_approx_eq MODPF.gramian!(RowMajor(), Array(T,n,n), X,  true) P
    @test_approx_eq MODPF.gramian!(ColumnMajor(), Array(T,n,n), X', true) P

    P = [dot(x,y) for x in Set_X, y in Set_Y]
    @test_approx_eq MODPF.gramian!(RowMajor(), Array(T,n,m), X,  Y)  P
    @test_approx_eq MODPF.gramian!(ColumnMajor(), Array(T,n,m), X', Y') P

    @test_throws DimensionMismatch MODPF.gramian!(RowMajor(), Array(T,n+1,n),   X, true)
    @test_throws DimensionMismatch MODPF.gramian!(RowMajor(), Array(T,n,n+1),   X, true)
    @test_throws DimensionMismatch MODPF.gramian!(RowMajor(), Array(T,n+1,n+1), X, true)

    @test_throws DimensionMismatch MODPF.gramian!(ColumnMajor(), Array(T,n+1,n),   X', true)
    @test_throws DimensionMismatch MODPF.gramian!(ColumnMajor(), Array(T,n,n+1),   X', true)
    @test_throws DimensionMismatch MODPF.gramian!(ColumnMajor(), Array(T,n+1,n+1), X', true)

    @test_throws DimensionMismatch MODPF.gramian!(RowMajor(), Array(T,n+1,m), X,  Y)
    @test_throws DimensionMismatch MODPF.gramian!(RowMajor(), Array(T,n,m+1), X,  Y)
    @test_throws DimensionMismatch MODPF.gramian!(ColumnMajor(), Array(T,n+1,m), X', Y')
    @test_throws DimensionMismatch MODPF.gramian!(ColumnMajor(), Array(T,n,m+1), X', Y')

    @test_throws DimensionMismatch MODPF.gramian!(RowMajor(), Array(T,m+1,n), Y,  X)
    @test_throws DimensionMismatch MODPF.gramian!(RowMajor(), Array(T,m,n+1), Y,  X)
    @test_throws DimensionMismatch MODPF.gramian!(ColumnMajor(), Array(T,m+1,n), Y', X')
    @test_throws DimensionMismatch MODPF.gramian!(ColumnMajor(), Array(T,m,n+1), Y', X')

end

info("Testing ", MODPF.squared_distance!)
for T in FloatingPointTypes
    Set_X = [rand(T,p) for i = 1:n]
    Set_Y = [rand(T,p) for i = 1:m]

    X = transpose(hcat(Set_X...))
    Y = transpose(hcat(Set_Y...))

    P = [dot(x-y,x-y) for x in Set_X, y in Set_X]
    G = MODPF.gramian!(RowMajor(), Array(T,n,n), X, true)
    xtx = MODPF.dotvectors(RowMajor(), X)

    @test_approx_eq MODPF.squared_distance!(G, xtx, true) P

    P = [dot(x-y,x-y) for x in Set_X, y in Set_Y]
    G = MODPF.gramian!(RowMajor(), Array(T,n,m), X, Y)
    xtx = MODPF.dotvectors(RowMajor(), X)
    yty = MODPF.dotvectors(RowMajor(), Y)

    @test_approx_eq MODPF.squared_distance!(G, xtx, yty)  P
    
    @test_throws DimensionMismatch MODPF.squared_distance!(Array(T,3,4), Array(T,3), true)
    @test_throws DimensionMismatch MODPF.squared_distance!(Array(T,4,3), Array(T,3), true)

    @test_throws DimensionMismatch MODPF.squared_distance!(Array(T,3,4), Array(T,2), Array(T,4))
    @test_throws DimensionMismatch MODPF.squared_distance!(Array(T,3,4), Array(T,4), Array(T,4))
    @test_throws DimensionMismatch MODPF.squared_distance!(Array(T,3,4), Array(T,3), Array(T,3))
    @test_throws DimensionMismatch MODPF.squared_distance!(Array(T,3,4), Array(T,3), Array(T,5))
end

