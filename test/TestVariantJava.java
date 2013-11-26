public class TestVariantJava {
  private static bridge_java bridge;

  public static void indent(int depth) {
    for (int i = 0; i < depth; ++i) {
      System.out.print("  ");
    }
  }

  public static void fn(variant2 v, int depth) {
    switch (v.which()) {
      case 0:
        indent(depth);
        System.out.println("blank");
        break;
      case 1:
        indent(depth);
        System.out.println("string:" + bridge.get_variant2_string(v));
        break;
      case 2:
        indent(depth);
        System.out.println("{");
        variant2_vector data = bridge.get_variant2_node(v).getData();
        for (int i = 0; i < data.size(); ++i) {
          fn(data.get(i), depth + 1);
        }
        indent(depth);
        System.out.println("}");
        break;
    }
  }

  public static void main(String[] args) {
    String path = args[0];
    System.load(path);
    bridge = new bridge_java();

    blank b = new blank();
    System.out.println(b);

    {
      variant1 v = new variant1();
      System.out.println(v);
      System.out.println(v.which());
      System.out.println(v.type_name());
      bridge.get_variant1_blank(v);

      v.set(bridge.make_variant1_double(42));
      System.out.println(v);
      System.out.println(v.which());
      System.out.println(v.type_name());
      System.out.println(bridge.get_variant1_double(v));

      v.set(bridge.make_variant1_string("foo"));
      System.out.println(v);
      System.out.println(v.which());
      System.out.println(v.type_name());
      System.out.println(bridge.get_variant1_string(v));

    }

    fn(bridge.get_variant2(), 0);

    {
      variant3 v = bridge.parse_variant3("42");
      assert v.which() == 0;
      assert bridge.get_variant3_int(v) == 42;
    }

    {
      variant3 v = bridge.parse_variant3("x");
      assert v.which() == 1;
      assert bridge.get_variant3_char(v) == 'x';
    }
  }
}
