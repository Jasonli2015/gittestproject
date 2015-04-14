package com.jason.extjs.gridPanel;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

import com.jason.extjs.gridPanel.entity.DeptModel;

public class TreeModel {
	
	private int id;
	private String text;
	private boolean leaf;
	private List<TreeModel> children = new ArrayList<TreeModel>();
	public TreeModel(){
		
	}
	
	/** 
     * 根据部门列表获取形如 [{id:"",text:"",leaf:,children:[]},{...},...]的JSON字符串 
     * @param models 部门列表List<DeptModel> 
     * @return JSON格式的字符串，用于生成ext树 
     */  
	public String getJsonTreeModelString(List<DeptModel> models){
		
		List<TreeModel> list = new ArrayList<TreeModel>(0);
		
		for (DeptModel mds : models) {
			if (mds.getParentno()==0) {
				TreeModel root = new TreeModel();
				root.setId(mds.getDeptno());
				root.setText(mds.getDeptname());
				//递归获取子集
				List<TreeModel> children = getChildren(models,root);
				if (children.size()>0) {
					root.setLeaf(false);
					root.setChildren(children);
				} else {
					root.setLeaf(true);
					root.setChildren(new ArrayList<TreeModel>(0));
				}
				list.add(root);
			} 
		}
		
		JsonConfig config = new JsonConfig();
		config.setExcludes(new String[]{"models"});
		config.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		
		return JSONArray.fromObject(list,config).toString();
		
	}
	
	/** 
     * 递归获取节点的子集的方法 
     * @param models 部门列表 
     * @param parentModel 根节点，即deptno=0的根节点部门 
     * @return List<TreeModel> 树模型列表 
     */  
	public List<TreeModel> getChildren(List<DeptModel> models, TreeModel parentModel){
		
		List<TreeModel> list = new ArrayList<TreeModel>(0);
		
		for (DeptModel mds : models) {
			if (parentModel.getId() == mds.getDeptno()) {
				TreeModel tm = new TreeModel();
				tm.setId(mds.getDeptno());
				tm.setText(mds.getDeptname());
				List<TreeModel> children = getChildren(models, tm);
				if (children.size()>0) {
					tm.setLeaf(false);
					tm.setChildren(children);
				} else {
					tm.setLeaf(true);
					tm.setChildren(new ArrayList<TreeModel>(0));
				}
				list.add(tm);
			} 
			
		}
		
		return list;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public boolean isLeaf() {
		return leaf;
	}
	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}
	public List<TreeModel> getChildren() {
		return children;
	}
	public void setChildren(List<TreeModel> children) {
		this.children = children;
	}
	
}
