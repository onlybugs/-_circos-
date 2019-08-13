

#4 使用图例,此处使用了3.6.1未跟新的包,所以用ps自己做一个图例吧
{
  #4.1 建立了一个例子函数
  {
    col_fun = colorRamp2(c(-2, 0, 2), c("green", "yellow", "red"))
    circlize_plot = function() {
      set.seed(12345)
      fa = letters[1:10]
      circos.initialize(fa, xlim = c(0, 1))
      circos.track(ylim = c(0, 1), panel.fun = function(x, y) {
        circos.points(runif(20), runif(20), cex = 0.5, pch = 16, col = 2)
        circos.points(runif(20), runif(20), cex = 0.5, pch = 16, col = 3)
      })
      circos.track(ylim = c(0, 1), panel.fun = function(x, y) {
        circos.lines(sort(runif(20)), runif(20), col = 4)
        circos.lines(sort(runif(20)), runif(20), col = 5)
      })
      
      for(i in 1:10) {
        circos.link(sample(fa, 1), sort(runif(10))[1:2], 
                    sample(fa, 1), sort(runif(10))[1:2],
                    col = add_transparency(col_fun(rnorm(1))))
      }
      circos.clear()
    }
  }
  
  #4.2 
  {
    
    
  }
}