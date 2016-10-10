import euler._

object Main extends App {

  val answer = (1 until 1000).filter((x) => x % 3 == 0 || x % 5 == 0).foldLeft(0)(_+_)

  println(answer)

}
