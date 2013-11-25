public class TestJava {
  public static void main(String[] args) {
    String path = args[0];
    System.out.println(path);
    System.load(path);

    Bridge.put_string("foo");
    System.out.println(Bridge.get_string());
  }
}
