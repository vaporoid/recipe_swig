public class TestJava {
  public static void main(String[] args) {
    String path = args[0];
    System.load(path);

    Bridge.put_string("foo");
    String s = Bridge.get_string();
    System.out.println(s);
  }
}
