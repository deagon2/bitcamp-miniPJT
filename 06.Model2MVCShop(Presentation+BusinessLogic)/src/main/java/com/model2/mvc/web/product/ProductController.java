package com.model2.mvc.web.product;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
public class ProductController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']?: 2}")
	int pageSize;
	
	@RequestMapping("/addProduct.do")
	public String addProduct(@ModelAttribute("product")Product product
							) throws Exception{
		product.setManuDate(product.getManuDate().replace("-", ""));
		productService.addProduct(product);
		return "redirect:/listProduct.do?menu=manage";
	}
	
	@RequestMapping("/getProduct.do")
	public String getProduct(@RequestParam("prodNo")int prodNo
							,HttpSession session
							,Model model
							) throws Exception{
		Product product = productService.getProduct(prodNo);
		product.setProdNo(prodNo);
		model.addAttribute("product",product);

		Map<Integer,String> viewListMap = new HashMap<Integer,String>();
		if(session.getAttribute("viewListMap") != null){
			viewListMap = (HashMap<Integer,String>)session.getAttribute("viewListMap");
		}
		viewListMap.put(prodNo,product.getProdName());
		if(viewListMap.size()>6){
			viewListMap.remove(6);
		}
		session.setAttribute("viewListMap", viewListMap);
		
		return "forward:/product/getProduct.jsp";
	}
	
	@RequestMapping("/updateProductView.do")
	public String updateProductView(@RequestParam("prodNo")int prodNo
							,Model model
							)throws Exception{
		model.addAttribute("product",productService.getProduct(prodNo));
		return "forward:/product/updateProductView.jsp";
	}
	
	@RequestMapping("/updateProduct.do")
	public String updateProduct(@ModelAttribute("product")Product product
							)throws Exception{
		productService.updateProduct(product);
		return "redirect:/listProduct.do?menu=manage";
	}
	
	@RequestMapping("/listProduct.do")
	public String listProduct(@ModelAttribute("search")Search search
							,@RequestParam(value="viewSoldItem", defaultValue="off")String viewSoldItem
							,Model model)throws Exception{
		if(viewSoldItem.equals("on")){
			search.setViewSoldItem(true);
		}
		if(search.getCurrentPage()==0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = productService.getProductList(search);
		Page resultPage = new Page(search.getCurrentPage()
						, ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("resultPage",resultPage);
		model.addAttribute("list",map.get("list"));
		model.addAttribute("search",search);
		return "forward:/product/listProduct.jsp";
	}
}
