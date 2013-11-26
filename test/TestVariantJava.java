public class TestVariantJava {
  public static void main(String[] args) {
    String path = args[0];
    System.load(path);

    blank b = new blank();
    System.out.println(b);
  }
}
