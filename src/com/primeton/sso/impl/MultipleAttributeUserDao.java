package com.primeton.sso.impl;

import java.util.Collections;
import java.util.Map;

public class MultipleAttributeUserDao extends StubPersonAttributeDaoImpl {
	 @Override
	  public Set getPerson(String uid) {
	      Map<String, List<Object>> attributes = new HashMap<String, List<Object>>();
	      attributes.put("from_name", Collections.<Object>singletonList(uid));
	      attributes.put("email", Collections.<Object>singletonList("123456@qq.com"));
	      attributes.put("phone", Collections.<Object>singletonList("123456"));
	      return new AttributeNamedPersonImpl(attributes);
	  }
}
