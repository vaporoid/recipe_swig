public class TestVariantJava {
  public static void main(String[] args) {
    String path = args[0];
    System.load(path);

    blank b = new blank();
    System.out.println(b);

    variant1 v = new variant1();
    System.out.println(v);
    System.out.println(v.which());
    System.out.println(v.type_name());
    Bridge.get_variant1_blank(v);

    v.set(Bridge.make_variant1_double(42));
    System.out.println(v);
    System.out.println(v.which());
    System.out.println(v.type_name());
    System.out.println(Bridge.get_variant1_double(v));

    v.set(Bridge.make_variant1_string("foo"));
    System.out.println(v);
    System.out.println(v.which());
    System.out.println(v.type_name());
    System.out.println(Bridge.get_variant1_string(v));
  }
}
