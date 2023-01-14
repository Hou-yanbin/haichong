package cart;

public class Cart {

	private String img_name = null;
	private String img_path =null;
	public String getImg_name() {
		return img_name;
	}
	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}
	public String getImg_path() {
		return img_path;
	}
	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}
	public Cart(String img_name, String img_path) {
		super();
		this.img_name = img_name;
		this.img_path = img_path;
	}
	public Cart() {
		super();
	}
}
