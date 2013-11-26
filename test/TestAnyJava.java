public class TestAnyJava {
  private static bridge_java bridge;

  public static void main(String[] args) {
    String path = args[0];
    System.load(path);
    bridge = new bridge_java();

    {
      any v = bridge.get_empty_any();
      assert v.empty();
    }

    {
      any v = bridge.get_any_int();
      assert !v.empty();
      System.out.println(bridge.get_any_int(v));
    }

    {
      any v = bridge.get_any_string();
      assert !v.empty();
      System.out.println(bridge.get_any_string(v));
    }

    {
      any v = bridge.get_any_sample();
      assert !v.empty();
      bridge.get_any_sample(v).run();
      v.set(bridge.get_empty_any());
    }

    {
      any v = bridge.make_any_int(69);
      assert !v.empty();
      System.out.println(bridge.get_any_int(v));
      System.out.println(v.type_name());
    }
  }
}
