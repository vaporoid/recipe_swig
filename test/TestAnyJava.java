public class TestAnyJava {
  public static void main(String[] args) {
    String path = args[0];
    System.load(path);

    {
      any v = Bridge.get_empty_any();
      assert v.empty();
    }

    {
      any v = Bridge.get_any_int();
      assert !v.empty();
      System.out.println(Bridge.any_cast_int(v));
    }

    {
      any v = Bridge.get_any_string();
      assert !v.empty();
      System.out.println(Bridge.any_cast_string(v));
    }

    {
      any v = Bridge.get_any_sample();
      assert !v.empty();
      Bridge.any_cast_sample(v).run();
      v.set(Bridge.get_empty_any());
    }

    {
      any v = Bridge.make_any_int(69);
      assert !v.empty();
      System.out.println(Bridge.any_cast_int(v));
    }
  }
}
