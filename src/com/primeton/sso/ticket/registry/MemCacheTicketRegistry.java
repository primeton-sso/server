/*
 * Copyright 2008 The JA-SIG Collaborative. All rights reserved. See license
 * distributed with this file and available online at
 * http://www.ja-sig.org/products/cas/overview/license/
 */
package com.primeton.sso.ticket.registry;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import java.util.concurrent.Future;

import net.spy.memcached.MemcachedClient;

import org.jasig.cas.ticket.ServiceTicket;
import org.jasig.cas.ticket.Ticket;
import org.jasig.cas.ticket.TicketGrantingTicket;
import org.jasig.cas.ticket.registry.AbstractDistributedTicketRegistry;
import org.springframework.beans.factory.DisposableBean;

/**
 * Memcache (or Repcache) backed ticket registry.
 * 
 * @author Scott Battaglia
 * @version $Revision: 1.1 $ $Date: 2013/10/12 06:49:51 $
 * @since 3.3
 * 
 */
public final class MemCacheTicketRegistry extends AbstractDistributedTicketRegistry implements DisposableBean {

	private final MemcachedClient client;

	private final int tgtTimeout;

	private final int stTimeout;

	private boolean synchronizeUpdatesToRegistry = false;

	/** 暂存所有的ticketID，供getTickets方法使用 **/
	private Set ticketIds = new HashSet();

	/**
	 * Host names should be given in a list of the format:
	 * &lt;hostname&gt;:&lt;port&gt;
	 * 
	 * @param hostnames
	 * @param ticketGrantingTicketTimeOut
	 * @param serviceTicketTimeOut
	 */
	public MemCacheTicketRegistry(final String[] hostnames, final int ticketGrantingTicketTimeOut, final int serviceTicketTimeOut) {
		this.tgtTimeout = ticketGrantingTicketTimeOut;
		this.stTimeout = serviceTicketTimeOut;
		final List addresses = new ArrayList();

		for(int i=0;i<hostnames.length;i++){
			String[] hostPort = hostnames[i].split(":");
			addresses.add(new InetSocketAddress(hostPort[0], Integer.parseInt(hostPort[1])));
		}
//		for (final String hostname : hostnames) {
//			
//		}

		try {
			this.client = new MemcachedClient(addresses);
		} catch (final IOException e) {
			throw new IllegalStateException(e);
		}
	}

	/**
	 * This alternative constructor takes time in milliseconds. It has the
	 * timeout parameters first because, otherwise it would be almost impossible
	 * to differentiate the two.
	 * 
	 * @param ticketGrantingTicketTimeOut
	 * @param serviceTicketTimeOut
	 * @param hostnames
	 */
	public MemCacheTicketRegistry(final long ticketGrantingTicketTimeOut, final long serviceTicketTimeOut, final String[] hostnames) {
		this(hostnames, (int) (ticketGrantingTicketTimeOut / 1000), (int) (serviceTicketTimeOut / 1000));
	}

	private void handleSynchronousRequest(final Future f) {
		try {
			if (this.synchronizeUpdatesToRegistry) {
				f.get();
			}
		} catch (final Exception e) {
			// ignore these.
		}
	}

	protected void updateTicket(final Ticket ticket) {
		if (ticket instanceof TicketGrantingTicket) {
			handleSynchronousRequest(this.client.replace(ticket.getId(), this.tgtTimeout, ticket));
		}

		if (ticket instanceof ServiceTicket) {
			handleSynchronousRequest(this.client.replace(ticket.getId(), this.stTimeout, ticket));
		}
	}

	public void addTicket(final Ticket ticket) {
		if (ticket instanceof TicketGrantingTicket) {
			handleSynchronousRequest(this.client.add(ticket.getId(), this.tgtTimeout, ticket));
		}

		if (ticket instanceof ServiceTicket) {
			handleSynchronousRequest(this.client.add(ticket.getId(), this.stTimeout, ticket));
		}
		ticketIds.add(ticket.getId());
	}

	public boolean deleteTicket(final String ticketId) {
		Future f = this.client.delete(ticketId);
		try {
			boolean result = ((Boolean)f.get()).booleanValue();
			if (result) {
				ticketIds.remove(ticketId);
				return true;
			} else {
				return false;
			}
		} catch (final Exception e) {
			log.error(e.getMessage(), e);
			return false;
		}
	}

	public Ticket getTicket(final String ticketId) {
		final Ticket t = (Ticket) this.client.get(ticketId);
		if (t == null) {
			return null;
		}

		return getProxiedTicketInstance(t);
	}

	/**
	 * This operation is not supported.
	 * 
	 * @throws UnsupportedOperationException
	 *             if you try and call this operation.
	 */
	public Collection getTickets() {
		List ticket = new LinkedList();
		Iterator it = ticketIds.iterator();
		while(it.hasNext()){
			Ticket t = getTicket((String) it.next());
			if (t != null) {
				ticket.add(t);
			}
		}
//		for (String ticketId : ticketIds) {
//			Ticket t = getTicket(ticketId);
//			if (t != null) {
//				ticket.add(t);
//			}
//		}
		return ticket;
	}

	public void destroy() throws Exception {
		this.client.shutdown();
	}

	public void setSynchronizeUpdatesToRegistry(final boolean b) {
		this.synchronizeUpdatesToRegistry = b;
	}
}
